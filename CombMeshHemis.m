function varargout = CombMeshHemis(voHemo, varargin)

% varargout = CombMeshHemis(voHemo, varargin);
%
%
%
% Khan 07/06/2011

%% Default params
HemoInit

Default varargin = {'White', 'Pia'}

%% Initialize

%% Main
% matlabpool open 8

voSurf = Str2Struct(varargin);
vout = cell(1, length(voSurf));
ctbDomain = cell(1, 2);

for oHemo = voHemo
cds(oHemo);
    % Combine L-R volumes
    % 	Destruct oHemo -> sSubject sRegion
    %     pL = AnatPath(oHemo, 'Left', '3DMeshes', 'White-Pia', 'White-Pia.mat');
    % 	ctbDomain{1} = Load();
    % 	ctbDomain{2} = Load(AnatPath(oHemo, 'Right', '3DMeshes', 'White-Pia', 'White-Pia.mat'));
    % 	tbDomain = CombineMatrices(ctbDomain);
    % 	Save(AnatPath(sSubject, sRegion, 'Both', '3DMeshes', 'White-Pia', 'White-Pia.mat'), tbDomain);
    
    % Combine L-R meshes
    for oSurf = voSurf
        if strcmpi(oSurf.name, 'White')
            sBothName = 'BothFullRefined.mat';
        else
            sBothName  = ['BothFull' oSurf.name 'Refined.mat'];
        end
        
        sName4Hemi  = FileExt(oSurf.name, '.raw');
        
        pLeft  = AnatPath(oHemo, 'Left', St(oHemo, 'Left', sName4Hemi));
        pRight = AnatPath(oHemo, 'Right', St(oHemo, 'Right', sName4Hemi));
        pBoth  = AnatPath(oHemo, '3DMeshes', sBothName);
        pBothLink = AnatPath(oHemo, 'Both', '3DMeshes', sName4Hemi);
        
                
        try
            oLeft  = RawMesh(pLeft);
            oRight = RawMesh(pRight);
            oBoth  = oLeft;
        catch ME
            Str(ME);
            keyboard
        end
        
        nVertices = length(oLeft.vertices);
        oRight.triangles = nVertices + oRight.triangles;
        
        csFields = {'initVertices', 'vertices', 'triangles', 'colors', 'normals', 'curvature'};
        
        for csField = csFields, sField = csField{1};
            try
                oBoth.(sField) = [oLeft.(sField), oRight.(sField)];
            end
        end
        
        oBoth.origin = -mean(oBoth.vertices,2);
        oBoth.name = sBothName;
        vout{oSurf.iNum} = oBoth;
        SaveMeshVista(oBoth, pBoth);
        link(pBoth, pBothLink);
    end
    
    varargout = vout(1:nargout);
    TextWaitbar(oHemo, oHemo);
end %function
% matlabpool close

%% Note: type "doc hungarian" for variable prefix explanation.
