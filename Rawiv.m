% Rawiv;
%
% Read/Write rawiv files. also translate and interp.
%
% Khan 03/23/2012

classdef Rawiv < dynamicprops
    
    %% Properties
    properties (SetAccess = public)
        filename, iFileConst, tData
        mBox, vScale, viDim, viDimFull
        oHeader, iSurf, sPre, iNum
    end
    
    %% Methods
    methods
        % Constructor
        function oRawiv = Rawiv(pFile, varargin)
            if nargin > 0
                oRawiv = Rawiv;
                if islogical(pFile)
                    oInput.tData = double(pFile) - 0.5;
                elseif isnumeric(pFile)
                    oInput.tData = double(pFile);
                elseif ischar(pFile)
                    oInput = ReadRawiv(pFile, varargin{:});
                else
                    oInput = pFile;
                end
                oRawiv = CopyStruct(oRawiv, oInput);
                oRawiv.Update;
            end
        end
        
        function err = CheckAlign(oRawiv, oRaw)
            err = Rms(LinearInterp(oRawiv,oRaw));
        end
        
        function mBBox = Box(oRawiv)
            mBBox = BoundingBox(oRawiv);
        end
        
        function t = tX(oRawiv)
            t = MeshGrid2(oRawiv.tData, oRawiv.vScale, oRawiv.mBox(1,:));
        end
        
        function t = tY(oRawiv)
            [~, t] = MeshGrid2(oRawiv.tData, oRawiv.vScale, oRawiv.mBox(1,:));
        end
        
        function t = tZ(oRawiv)
            [~, ~, t] = MeshGrid2(oRawiv.tData, oRawiv.vScale, oRawiv.mBox(1,:));
        end
        
        function [tX tY tZ] = MeshGrid(oRawiv)
            tX = oRawiv.tX;
            tY = oRawiv.tY;
            tZ = oRawiv.tZ;
        end
        
        function mCoords = mCoords(oRawiv)
            [~, ~, ~, mCoords] = MeshGrid2(oRawiv.tData, oRawiv.vScale, oRawiv.mBox(1,:));
        end
        
        function vX = vX(oRawiv)
            [~,~,~,~, vX] = MeshGrid2(oRawiv.tData, oRawiv.vScale, oRawiv.mBox(1,:));
        end
        
        function vY = vY(oRawiv)
            [~,~,~,~,~, vY] = MeshGrid2(oRawiv.tData, oRawiv.vScale, oRawiv.mBox(1,:));
        end
        function vZ = vZ(oRawiv)
            [~,~,~,~,~,~, vZ] = MeshGrid2(oRawiv.tData, oRawiv.vScale, oRawiv.mBox(1,:));
        end
        
        function oRawiv = Update(oRawiv)
            oRawiv = RawivUpdate(oRawiv);
        end
        
        function oRawiv = Equals(oRawiv, oRawiv2)
            oRawiv = CopyStruct(oRawiv, oRawiv2);
        end
        
        function oRawiv = Set(oRawiv, varargin)
            for iArg = 2:nargin
                SetSub(oRawiv,  varargin{iArg-1}, inputname(iArg))
            end
        end
        
        function oMesh = Mesh(oRawiv, varargin)
            oMesh = Vol2Mesh(oRawiv, varargin{:}, 'align', 'fix');
        end
        
        function oRawiv = Translate(oRawiv, vTrans, varargin)
            oRawiv.mBox = oRawiv.mBox + [vTrans; vTrans];
            if ~Option('fast'), oRawiv = oRawiv.Update; end;
        end
        
        function oRawiv = InterpFull(oRawiv, varargin)
            oRawiv = InterpRawivFull(oRawiv, oRawiv.viDimFull, varargin{:});
        end
        
        function oRawiv = subsasgn(oRawiv, voInd, xValue)
            ciInd = voInd(1).subs;
            sProp = voInd(end).subs;
            if isempty(oRawiv), oRawiv = Rawiv; end
            switch [voInd.type]
                case '().'
                    try oRawiv(ciInd{:});
                    catch oRawiv(ciInd{:}) = Rawiv; end
                    try oRawiv(ciInd{:}).addprop(sProp); end
                    oRawiv(ciInd{:}).(sProp) = xValue;
                case '.'
                    sProp = voInd.subs;
                    try oRawiv.addprop(sProp); end
                    try
                        oRawiv.(sProp) = xValue;
                    catch me
                        dbstack
                        Str(me.message);
                    end
                otherwise
                    oRawiv = builtin('subsasgn', oRawiv, voInd, xValue);
            end
        end
        
        function Show(oRawiv, varargin)
            Slide(oRawiv, varargin{:});
        end
        
        function pOutFile = Save(oRawiv, varargin)
            pOutFile = WriteRawiv(oRawiv, varargin{:});
        end
        
        function oRawiv3 = minus(oRawiv1, oRawiv2)
            oRawiv3 = Rawiv;
            if ~isObStruct(oRawiv1)
                oRawiv3.tData = oRawiv1-oRawiv2.tData;
            elseif ~isObStruct(oRawiv2)
                oRawiv3.tData = -oRawiv2+oRawiv1.tData;
            else
                oRawiv3.tData = oRawiv1.tData-oRawiv2.tData;
            end
            oRawiv3.Update;
        end
        
        function oRawiv3 = plus(oRawiv1, oRawiv2)
            if ~isObStruct(oRawiv1)
                oRawiv3 = Rawiv(oRawiv2);
                oRawiv3.tData = oRawiv1+oRawiv2.tData;
            elseif ~isObStruct(oRawiv2)
                oRawiv3 = Rawiv(oRawiv1);
                oRawiv3.tData = oRawiv2+oRawiv1.tData;
            else
                oRawiv3 = Rawiv(oRawiv1);
                oRawiv3.tData = oRawiv1.tData+oRawiv2.tData;
            end
            oRawiv3.Update;
        end
        
        function oRawiv3 = rdivide(oRawiv1, oRawiv2)
            if ~isObStruct(oRawiv1)
                oRawiv3 = Rawiv(oRawiv2);
                oRawiv3.tData = oRawiv1./oRawiv2.tData;
            elseif ~isObStruct(oRawiv2)
                oRawiv3 = Rawiv(oRawiv1);
                oRawiv3.tData = oRawiv2./oRawiv1.tData;
            else
                oRawiv3 = Rawiv(oRawiv2);
                oRawiv3.tData = oRawiv1.tData./oRawiv2.tData;
            end
            oRawiv3.Update;
        end
        
        function oRawiv3 = times(oRawiv1, oRawiv2)
            if ~isObStruct(oRawiv1)
                oRawiv3 = Rawiv(oRawiv2);
                oRawiv3.tData = oRawiv1*oRawiv2.tData;
            elseif ~isObStruct(oRawiv2)
                oRawiv3 = Rawiv(oRawiv1);
                oRawiv3.tData = oRawiv2*oRawiv1.tData;
            else
                oRawiv3 = Rawiv(oRawiv2);
                oRawiv3.tData = oRawiv1.tData*oRawiv2.tData;
            end
            oRawiv3.Update;
        end
        
        function oRawiv3 = mtimes(oRawiv1, oRawiv2)
            if ~isObStruct(oRawiv1)
                oRawiv3 = Rawiv(oRawiv2);
                oRawiv3.tData = oRawiv1*oRawiv2.tData;
            elseif ~isObStruct(oRawiv2)
                oRawiv3 = Rawiv(oRawiv1);
                oRawiv3.tData = oRawiv2*oRawiv1.tData;
            else
                oRawiv3 = Rawiv(oRawiv2);
                oRawiv3.tData = oRawiv1.tData*oRawiv2.tData;
            end
            oRawiv3.Update;
        end
        
        function oRawiv = Align2Mesh(oRawiv, varargin)
            oRawiv = AlignVol2Mesh(oRawiv, varargin{:});
        end
        function oRawiv = RepairSigns(oRawiv, varargin)
            oRawiv = FixSdf(oRawiv, varargin{:});
        end
    end % Methods
end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
