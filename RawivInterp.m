% RawivInterp(oRawiv0, oRawiv1, nSurfs);
%
%
%
% Khan 04/15/2012

classdef RawivInterp < dynamicprops
    properties (SetAccess = public)
        oRawiv0, oRawiv1, iSurf, nSurfs, iNum = 1;
    end
    
    methods % constructor
        function oRawivInterp = RawivInterp(oRawiv0, oRawiv1, nSurfs, varargin)
            if nargin > 0
                oRawivInterp.oRawiv0 = Rawiv(oRawiv0);
                oRawivInterp.oRawiv1 = Rawiv(oRawiv1);
                oRawivInterp.nSurfs = nSurfs;
            end % constructor
        end % methods
        
        function voMesh = MeshArray(o, oCentMesh)
            voMesh(1) = RawMesh(PrevFile(oCentMesh));
            voMesh(2) = RawMesh(oCentMesh);
            voMesh(3) = RawMesh(NextFile(oCentMesh));
            
            nSamples = 1e5;
            for o1Mesh = voMesh
                nVerts = length(o1Mesh.vertices);
                if nVerts > nSamples
                    vi = randsample(1:nVerts,1e5);
                    o1Mesh.vertices = o1Mesh.vertices(:,vi);
                    o1Mesh.normals = o1Mesh.normals(:,vi);
                end
                voMesh(o1Mesh.iNum) = o1Mesh;
            end
            
            o.iSurf = o1Mesh.iSurf;
        end
        
        function oMesh = Mesh(o, iSurf)
            oRawiv = o.Vol(iSurf);
            oMesh = oRawiv.Mesh(0,0,'fix');
        end
        
        function oRawiv = Vol(o, iSurf)
            o.iSurf = iSurf;
            nSurfs = o.nSurfs;
            oRawiv0 = o.oRawiv0;
            oRawiv1 = o.oRawiv1;
            
            A = 1-iSurf/(nSurfs-1);
            B = iSurf/(nSurfs-1);
            
            oRawiv = A*oRawiv0 + B*oRawiv1;
            oRawiv.iSurf = iSurf;
            oRawiv.filename = regexprep(o.oRawiv0.filename, '[0-9]*.rawiv', Str(iSurf, '.rawiv'));
        end
        
        function oRawiv = w(o, w)
            oRawiv = o.Surf(round(w*o.iFinal));
        end
    end % methods
end % classdef


%% Note: type "doc hungarian" for variable prefix explanation.
