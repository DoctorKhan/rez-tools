% Seg;
%
% Read/Write rawiv files. also translate and interp.
%
% Khan 03/23/2012

classdef Seg < dynamicprops
    %% Properties
    properties (SetAccess = public)
        filename, type, header, tData,
        tFull, tSeg, viDim, oMesh, iNum, vAdj, iType, sType, iRefine
        White, Gray, Pia
    end
    
    %% Methods
    methods
        % Constructor
        function oSeg = Seg(oHemo, sHemi, varargin)
            Destruct oHemo weakly;
            Default sHemi = "Both"
            %             sType = CellMatch(varargin, @isTissue);
            
            sFilename = FileExt(sSubject, sHemi, varargin{:}, 'Class', 'weakly');
            filename = AnatPath(oHemo, sHemi, sFilename);
            oClass = readClassFile(filename);
            
            tData = oClass.data;
            oType = oClass.type;
            oSeg.header = oClass.header;
            
            tbGray = tData == 0;
            tbWhite = tData == oType.white;
            tbPia = tbWhite | tbGray;
            
            oSeg.White = Rawiv(tbWhite);
            oSeg.Gray  = Rawiv(tbGray);
            oSeg.Pia   = Rawiv(tbPia);
            
            oSeg = CopyStruct(oSeg, Struct(filename, tData));
            oSeg.type = oClass.type;
            oSeg = oSeg.Update;
        end
        
        function oSeg = Equals(oSeg, oSeg2)
            oSeg = CopyStruct(oSeg, oSeg2);
        end
        
        function oSeg = Translate(oSeg, vAdj)
            Default vAdj = oSeg.vAdj;
            oSeg.mBox = oSeg.mBox + [vAdj; vAdj];
            oSeg.vAdj = vAdj;
        end
        
        function oSeg = Update(oSeg)
            if defined('oSeg.sType')
                switch oSeg.sType
                    case 'white'
                        oSeg.tSeg = oSeg.White;
                    otherwise
                        oSeg.tSeg = oSeg.tData;
                end
            end
            oSeg.viDim = size(oSeg.tData);
        end
        
        function mCoords = mCoords(oRawiv)
            [~, ~, ~, mCoords] = MeshGrid2(oRawiv.tData, oRawiv.vScale, oRawiv.mBox(1,:));
        end
        
        function t = tX(oSeg)
            t = MeshGrid2(oSeg.tData, oSeg.vScale, oSeg.mBox(1,:));
        end
        function t = tY(oSeg)
            [~, t] = MeshGrid2(oSeg.tData, oSeg.vScale, oSeg.mBox(1,:));
        end
        function t = tZ(oSeg)
            [~, ~, t] = MeshGrid2(oSeg.tData, oSeg.vScale, oSeg.mBox(1,:));
        end
        
        function oSeg = InterpFull(oSeg)
            viDimF = oSeg.viDim + 1;
            [x, y, z] = meshgrid(1:viDimF(1), 1:viDimF(2), 1:viDimF(3));
            oSeg.tFull = interp3(oSeg.tX, oSeg.tY,oSeg.tZ, oSeg.tData, x, y, z);
        end
        
        function Save(oSeg, varargin)
            Default pFile = oSeg.filename;
            pFile = FileExt(varargin{:}, 'Class', 'weakly');
            if defined('pFile')
                writeClassFile(oSeg, pFile);
            end
        end
        
        function oSeg = plus(oSeg, oSeg2)
            if isSeg(oSeg2), [oSeg, oSeg2] = swap(oSeg, oSeg2); end
            oSeg = MathOp(oSeg2, @plus);
        end
        
        function oSeg = times(oSeg, oSeg2)
            if isSeg(oSeg2), [oSeg, oSeg2] = swap(oSeg, oSeg2); end
            oSeg = MathOp(oSeg, @times);
        end
        
        function oSeg = mtimes(oSeg, oSeg2)
            if isSeg(oSeg2), [oSeg, oSeg2] = swap(oSeg, oSeg2); end
            oSeg = MathOp(oSeg2, @mtimes);
        end
        
        function tbWhite = ExtractWhite(oSeg)
            tbWhite = oSeg.tData == oSeg.type.white;
        end
        
        function tbGray = ExtractGray(oSeg)
            tbGray = oSeg.tData == oSeg.type.gray;
            tbUnknown = oSeg.tData == oSeg.type.unknown;
            tbGray = tbGray | tbUnknown;
        end
        
        function tVol = ExtractPia(oSeg)
            tVol = oSeg.White | oSeg.Gray;
        end
        
        function oSeg = AlignSeg2Mesh(oSeg, oMesh, sType)
            Default oRaw = oSeg.oMesh & sType = "gray"
            oRaw = RawMesh(oMesh);
            
            % Main
            Str('Aligning segmentation to mesh...');
            vAdj = oRaw.Align2Vol(oSeg.tData == oSeg.type.(sType));
            oRaw.vertices = oRaw.initVertices;
            
            oSeg.Translate(-vAdj);
            Str('Translate volume by', -vAdj);
        end
        
        function oMesh = Mesh(oSeg, iRefine, sType, varargin)
            Default iRefine = 0 & sType = "white"
            
            if strcmpi(sType, 'white')
                sExt = 'White.raw';
            else
                sExt = 'Pia.raw';
            end
            
            [iRefine, sType] = Destruct(oSeg, iRefine, sType, 'weakly');
            tVol = oSeg.(TitleCase(sType));
            
            oMesh = RawMesh(BuildMesh(tVol, '', 0));
            if iRefine > 0, oMesh.Refine(iRefine); end
            
            oMesh.filename = [FileExt(oSeg.filename, '') sExt];
            if Option('Save') || nargout == 0
                oMesh.Save;
            end
        end
    end
end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
