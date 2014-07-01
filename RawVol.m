% RawVol;
%
% Read/Write rawiv files. also translate and interp.
%
% Khan 03/23/2012

classdef RawVol < dynamicprops
    
    %% Properties
    properties (SetAccess = public)
        filename, iFileConst, tData
        oHeader, iSurf, sPre, iNum
    end
    
    properties (SetAccess = private)
        mBox;
    end
    
    %% Methods
    methods
        % Constructor
        function oRawVol = RawVol(pFile, varargin)
            if nargin > 0
                oRawVol = RawVol;
                if is3d(pFile)
                    oInput.tData = pFile;
                elseif ischar(pFile)
                    oInput = ReadRawVol(pFile, varargin{:});
                else
                    oInput = pFile;
                end
                oRawVol = CopyStruct(oRawVol, oInput);
                oRawVol.Update;
            end
        end
        
        function mBBox = Box(oRawVol)
            [tData, vScale, mBox(1,:)] = Destruct(oRawVol);
            mSpan = [vScale; vScale];
            mLower = [mBox(1,:); mBox(1,:)];
            tbBBox = isfinite(tData) & tData ~=0;
            mBBox = BoundingBox(tbBBox).*mSpan + mLower;
        end
        
        function t = tX(oRawVol)
            t = MeshGrid2(oRawVol.tData, oRawVol.vScale, oRawVol.mBox(1,:));
        end
        
        function t = tY(oRawVol)
            [~, t] = MeshGrid2(oRawVol.tData, oRawVol.vScale, oRawVol.mBox(1,:));
        end
        
        function t = tZ(oRawVol)
            [~, ~, t] = MeshGrid2(oRawVol.tData, oRawVol.vScale, oRawVol.mBox(1,:));
        end
        
        function [tX tY tZ] = MeshGrid(oRawVol)
            tX = oRawVol.tX;
            tY = oRawVol.tY;
            tZ = oRawVol.tZ;
        end
        
        function mCoords = mCoords(oRawVol)
            [~, ~, ~, mCoords] = MeshGrid2(oRawVol.tData, oRawVol.vScale, oRawVol.mBox(1,:));
        end
        
        function vX = vX(oRawVol)
            [~,~,~,~, vX] = MeshGrid2(oRawVol.tData, oRawVol.vScale, oRawVol.mBox(1,:));
        end
        
        function vY = vY(oRawVol)
            [~,~,~,~,~, vY] = MeshGrid2(oRawVol.tData, oRawVol.vScale, oRawVol.mBox(1,:));
        end
        function vZ = vZ(oRawVol)
            [~,~,~,~,~,~, vZ] = MeshGrid2(oRawVol.tData, oRawVol.vScale, oRawVol.mBox(1,:));
        end
        
        function oRawVol = Update(oRawVol)
            oRawVol = RawVolUpdate(oRawVol);
        end
        
        function oRawVol = Equals(oRawVol, oRawVol2)
            oRawVol = CopyStruct(oRawVol, oRawVol2);
        end
        
        function oRawVol = Set(oRawVol, varargin)
            for iArg = 2:nargin
                SetSub(oRawVol,  varargin{iArg-1}, inputname(iArg))
            end
        end
        
        function oMesh = Mesh(oRawVol, varargin)
            oMesh = Vol2Mesh(oRawVol, varargin{:}, 'align', 'fix');
        end
        
        function oRawVol = Translate(oRawVol, vTrans, varargin)
            oRawiv = Rawiv(oRawVol);
            oRawVol.mBox = o + [vTrans; vTrans];
            oRawVol = RawVol(oRawiv);
            if ~Option('fast'), oRawVol = oRawVol.Update; end;
        end
        
        function oRawVolFull = InterpFull(oRawVol, viDim)
            oRawVolFull = RawVol(oRawVol);
            Limits = oRawVolFull.Limits;
            if defined('viDim')
            viDim = Default(viDim);
            end
            
            viDim = Default(GetDimFromAnat);
                
            viDim = Default(ceil(max(oRawVolFull.vertices)));
         
            oVolPts.vertices = MeshGrid2(Limits);
            vIntData = LinearInterp(oRawVol, oVolPts);
            
            tData = reshape(vIntData, viDim);
            
            viDim        = viDim;
            mBox(2,:)    = viDim-1;
            
            oRawVolFull = CopyStruct(tData, Limits, tData);
            oRawVolFull.Update;
        end
        
        function oRawVol = subsasgn(oRawVol, voInd, xValue)
            ciInd = voInd(1).subs;
            sProp = voInd(end).subs;
            if isempty(oRawVol), oRawVol = RawVol; end
            switch [voInd.type]
                case '().'
                    try oRawVol(ciInd{:});
                    catch oRawVol(ciInd{:}) = RawVol; end
                    try oRawVol(ciInd{:}).addprop(sProp); end
                    oRawVol(ciInd{:}).(sProp) = xValue;
                case '.'
                    sProp = voInd.subs;
                    try oRawVol.addprop(sProp); end
                    try
                        oRawVol.(sProp) = xValue;
                    catch me
                        dbstack
                        Str(me.message);
                    end
                otherwise
                    oRawVol = builtin('subsasgn', oRawVol, voInd, xValue);
            end
        end
        
        function Show(oRawVol, varargin)
            Slide(oRawVol, varargin{:});
        end
        
        function pOutFile = Save(oRawVol, varargin)
            pOutFile = WriteRawVol(oRawVol, varargin{:});
        end
        
        function oRawVol3 = minus(oRawVol1, oRawVol2)
            oRawVol3 = RawVol;
            if ~isObStruct(oRawVol1)
                oRawVol3.tData = oRawVol1-oRawVol2.tData;
            elseif ~isObStruct(oRawVol2)
                oRawVol3.tData = -oRawVol2+oRawVol1.tData;
            else
                oRawVol3.tData = oRawVol1.tData-oRawVol2.tData;
            end
            oRawVol3.Update;
        end
        
        function oRawVol3 = plus(oRawVol1, oRawVol2)
            if ~isObStruct(oRawVol1)
                oRawVol3 = RawVol(oRawVol2);
                oRawVol3.tData = oRawVol1+oRawVol2.tData;
            elseif ~isObStruct(oRawVol2)
                oRawVol3 = RawVol(oRawVol1);
                oRawVol3.tData = oRawVol2+oRawVol1.tData;
            else
                oRawVol3 = RawVol(oRawVol1);
                oRawVol3.tData = oRawVol1.tData+oRawVol2.tData;
            end
            oRawVol3.Update;
        end
        
        function oRawVol3 = rdivide(oRawVol1, oRawVol2)
            if ~isObStruct(oRawVol1)
                oRawVol3 = RawVol(oRawVol2);
                oRawVol3.tData = oRawVol1./oRawVol2.tData;
            elseif ~isObStruct(oRawVol2)
                oRawVol3 = RawVol(oRawVol1);
                oRawVol3.tData = oRawVol2./oRawVol1.tData;
            else
                oRawVol3 = RawVol(oRawVol2);
                oRawVol3.tData = oRawVol1.tData./oRawVol2.tData;
            end
            oRawVol3.Update;
        end
        
        function oRawVol3 = times(oRawVol1, oRawVol2)
            if ~isObStruct(oRawVol1)
                oRawVol3 = RawVol(oRawVol2);
                oRawVol3.tData = oRawVol1*oRawVol2.tData;
            elseif ~isObStruct(oRawVol2)
                oRawVol3 = RawVol(oRawVol1);
                oRawVol3.tData = oRawVol2*oRawVol1.tData;
            else
                oRawVol3 = RawVol(oRawVol2);
                oRawVol3.tData = oRawVol1.tData*oRawVol2.tData;
            end
            oRawVol3.Update;
        end
        
        function oRawVol3 = mtimes(oRawVol1, oRawVol2)
            if ~isObStruct(oRawVol1)
                oRawVol3 = RawVol(oRawVol2);
                oRawVol3.tData = oRawVol1*oRawVol2.tData;
            elseif ~isObStruct(oRawVol2)
                oRawVol3 = RawVol(oRawVol1);
                oRawVol3.tData = oRawVol2*oRawVol1.tData;
            else
                oRawVol3 = RawVol(oRawVol2);
                oRawVol3.tData = oRawVol1.tData*oRawVol2.tData;
            end
            oRawVol3.Update;
        end
        
        function oRawVol = Align2Mesh(oRawVol, varargin)
            oRawVol = AlignVol2Mesh(oRawVol, varargin{:});
        end
    end % Methods
end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
