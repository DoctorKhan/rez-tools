% function TestIsomeshes

% TestIsomeshes;
%
%
%
% Khan 04/11/2012

%% Default params
Default sPre = "Inter300s"
Default nSurfs = 8 & iRefine = 5;
iFinal = nSurfs - 1;

%%
Default oRawiv0 = Rawiv(sPre, 0);
Default oRawiv1 = Rawiv(sPre, iFinal);

%% Initialize

%% Main
%  [oMesh, oRawiv0, oRawiv1, r] = IsoMeshes(oRawiv0, oRawiv1, nSurfs);

%%
for ii = 1:14
    oMesh = RawMesh(sPre, ii); fin(oMesh);
    oMesh.Refine(5);
    if fin(oMesh) < 99
        fin(oMesh);
        break;
        ii
    end
    oMesh.Save;
end

% end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
