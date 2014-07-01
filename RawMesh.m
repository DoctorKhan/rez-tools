% RawMesh Class;
%
%
%
% Khan 03/24/2012

classdef RawMesh < dynamicprops
    %% Properties
    properties (SetAccess = public)
        filename
        vertices, initVertices, normals, triangles, mColors
        distance, curvature, mInterDist, tbDom, bUnits = true
        nVerts, viDim, mmPerVox0, mmPerVox = [1 1 1]
        mMeshBox, vbSubset, coef, units
        vAdj, lastErr, bUpdateDistance = false
        smooth_iterations = 0, iRefine = 0
        vbGood, vbStopped, sPrefix,
        
        pFirst, pLast, mSpan
        iNum=1, iSurf=0, iFinal, nSurfs, nTot
        EvalNorm, oRawivInterp, oTrunc, oVolume, tbVolume, tTraj
        viSurf, miSurf
        vbLanded, vbBehind, vbOldFailure, vbNewFailure,
    end
    
    properties (SetAccess = private)
        normtype = 'none', normsrc = 'none';
    end
    
    
    %% Methods
    methods
        % Constructor
        function oRaw = RawMesh(varargin)
            if nargin > 0
                oRaw = RawMeshCons(varargin{:});
            end
        end
        
        function oRaw = Update(oRaw, iSurf)
            oRaw.iSurf = iSurf;
            if ~isempty(oRaw.iSurf)
                pNewFilename = Str(oRaw.iSurf, '.raw');
                oRaw.filename = regexprep(oRaw.filename, '[0-9]*.raw', pNewFilename);
            end
        end
        
        function tb = tbDomain(oRaw)
            if isempty(oRaw.tbDom)
                [~, ctbDomain] = Domains4DepthMap;
                tb = ctbDomain{2};
                oRaw.tbDom = tb;
            else
                tb = oRaw.tbDom;
            end
        end
        
        function mBox = Box(oRaw)
            mBox = BoundingBox(oRaw);
        end
        
        function Truncate(oRaw, iDim, iMin, iMax)
            if notDefined('iDim')
                vbTrunc = oRaw.vbGood;
            else
                vbTrunc = oRaw.vertices(iDim,:) < iMin | oRaw.vertices(iDim,:) > iMax;
            end
            
            Str('Removing', 100*frac(vbTrunc), '% of the mesh points.');
            mExcessVerts = oRaw.vertices(:,vbTrunc);
            mExcessNorms = oRaw.normals(:,vbTrunc);
            
            oRaw.vertices(:,vbTrunc) = nan;
            oRaw.normals(:,vbTrunc) = nan;
            oRaw.oTrunc = Struct(mExcessVerts, mExcessNorms, vbTrunc);
        end
        
        function RestoreTrunc(oRaw)
            Destruct oRaw.oTrunc
            mVerts(:,vbTrunc) = oRaw.vertices;
            mNorms(:,vbTrunc) = oRaw.normals;
            mVerts(:,~vbTrunc) = mExcessVerts;
            mNorms(:,~vbTrunc) = mExcessNorms;
            oRaw.vertices = mVerts;
            oRaw.normals = mNorms;
            oRaw.oTrunc = [];
        end
        
        function [pFile, oRaw] = Save(oRaw, varargin)
            if CellMatch(varargin, '\.mat$')
                [pFile, oRaw] = SaveMeshVista(oRaw, varargin{:});
            else
                [pFile, oRaw] = SaveMeshRaw(oRaw, varargin{:}); % Save to second argument or oRaw.filename
            end
        end
        
        function oRaw = NormSurf(oRaw, varargin)
            oRaw = MeshNormSurf(oRaw, varargin{:});
        end
        
        function oStruct = Struct(oRaw)
            oStruct = Obj2Struct(oRaw);
        end
        
        function oRaw = Verts(oRaw, mVerts)
            oRaw.initVertices = oRaw.vertices;
            if defined('mVerts')
                oRaw.vertices = mVerts;
            end
        end
        
        function oRaw = subsasgn(oRaw, voInd, xValue)
            ciInd = voInd(1).subs;
            sProp = voInd(end).subs;
            if isempty(oRaw), oRaw = RawMesh; end
            switch [voInd.type]
                case '().'
                    try
                        oRaw(ciInd{:});
                    catch
                        oRaw(ciInd{:}) = RawMesh;
                    end
                    
                    try oRaw(ciInd{:}).addprop(sProp); end
                    oRaw(ciInd{:}).(sProp) = xValue;
                case '.'
                    sProp = voInd.subs;
                    try oRaw.addprop(sProp); end
                    oRaw.(sProp) = xValue;
                otherwise
                    oRaw = builtin('subsasgn', oRaw, voInd, xValue);
            end
            
            nTot = length(oRaw);
            for ii = 1:nTot
                oRaw(ii).iNum = ii;
                oRaw(ii).nTot = nTot;
            end
        end
        
        function oRaw = Color(oRaw, vColor)
            oColor = Cmap;
            mColor = oColor(vColor)';
            n2Set = length(vColor);
            nVerts = size(oRaw.vertices,2);
            oRaw.mColors = repmat(mColor, 1, nVerts/n2Set);
        end
        
        function oMesh = FixNormals(oMesh, oRawiv, varargin)
            oMesh = FixMeshNormals(oMesh, oRawiv, varargin{:});
        end
        
        function oRaw = NormGrid(oRaw, varargin)
            oRaw = GridNormals(oRaw, varargin{:});
        end
        
        function oRaw = NormInterp(oRaw, varargin)
            oRaw = MeshNormInterp(oRaw, varargin{:});
        end
        function oRaw = NormInit(oRaw, varargin)
            oRaw = MeshNormInit(oRaw, varargin{:});
        end
        
        function oRaw = NormGrad(oRaw, oRawiv, varargin)
            oRaw = MeshGradNorm(oRaw, oRawiv, varargin{:});
        end
        
        function oRaw = Translate(oRaw, varargin)
            oRaw = TransScale(oRaw, varargin{:});
        end
        
        function oRaw = Align2Vol(oRaw, oVol)
            [oRaw oRaw.vAdj, oRaw.lastErr] = AlignMesh2Vol(oRaw, oVol);
        end
        
        function bProp = isfield(oRaw, sField)
            bProp = isSub(oRaw, sField);
        end
        
        function oRaw = Refine(oRaw, varargin)
            oRaw = meshRefine(oRaw, varargin{:});
        end
        
        function Reset(oRaw)
            oRaw.vertices = oRaw.initVertices;
        end
        
        function oRaw2 = plus(oRaw, n)
            if isnumeric(oRaw)
                [oRaw, n] = swap(oRaw, n);
            end
            
            oRaw2 = RawMesh(oRaw);
            oRaw2.vertices = MatrixVectorSum(oRaw.vertices,n);
        end
        
        function oRaw = mtimes(oRaw, n)
            if isnumeric(oRaw), [oRaw, n] = swap(oRaw, n); end
            oRaw2 = RawMesh(oRaw);
            oRaw2.vertices = MatrixVectorProd(oRaw.vertices,n);
        end
        
        % Volume(viDim, mmPerVox, vTrans)
        function [tVol, viDim] = Volume(oRaw, varargin)
            [tVol, viDim] = Mesh2Vol(oRaw, varargin{:});
        end
        
        function oRawiv = SignedDistance(oRaw, varargin)
            oRawiv = SignedDistFunc(oRaw, oRaw.viDim, varargin{:});
        end
        
        function alignErr = CheckAlign(oMesh)
            vInt = LinearInterp(oMesh, oMesh.oVolume);
            [alignErr s] = mss(abs(vInt));
            Str('Alignment error:', alignErr, '+/-', s);
        end
        
        function oNorm = NormDist(oWhiteMsh, oPialMsh, oSeg)
            oNorm = NormSdf(oWhiteMsh, oPialMsh, oSeg);
        end
    end % methods
end % classdef


%% Note: type "doc hungarian" for variable prefix explanation.
