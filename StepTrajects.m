function voMesh = StepTrajects(sSeries, nSurfs, varargin)

% StepTrajects;
%
%
%
% Khan 03/05/2012
 
%% Default params
Default sSeries = Inter400
sPrefix = [sSeries 's'];
Default nSurfs = 9;
iLastSurf = nSurfs-1;
%% Initialize
for iSurf = [1 3]
    TextWaitbar(iSurf/iLastSurf)
    iNext = iSurf+1;
    Str('Reading files...'); 
    tic;
    oRawiv = ReadRawiv([sPrefix num2str(iSurf) '.rawiv'], 'struct'); 
    Destruct oRawiv
    pSurf = [sPrefix num2str(iSurf)];
    if exist([pSurf '.mat'], 'file')
        load([pSurf '.mat'], 'file')
    else
        oMesh = ReadRawFileIntoMesh([sPrefix num2str(iSurf) '.raw']);
        oMesh2 = ReadRawFileIntoMesh([sPrefix num2str(iNext) '.raw']); 
    end
    toc

    d = mean(Mag(oMesh2.vertices - 150.5)) - mean(Mag(oMesh.vertices - 150.5))
    %% Main
    tic
        [oMesh oMesh2] = StepTraject(oMesh, oMesh2, oRawiv); 
    toc
    Destruct oMesh
%%
    d2 = Mag(vertices + normals - 150.5) - Mag(vertices - 150.5);
    [mean(d) std(d)]
    save([pSurf '.mat'], 'oMesh', 'oMesh2')
    
    voMesh(iNext) = oMesh2;
end

%% Interpolate
% for oMesh = voMesh
%     d = oMesh.vDist(oMesh.nearest);
nVerts = length(vertices);
vSteps = 0:0.2:10; nSteps = length(vSteps);

tSteps = repmat(vSteps', [1 nVerts 3]); %nsteps x nverts x 3
t = 1:nVerts;
t = repmat(t, nSteps, 1);
repmat(t, 
mSteps = reshape(tSteps,[],3);
vDist = mSteps(:,1);

mSteps = repmat(VertVec(v0), [1 3]);
tSteps = repmat(mSteps, nSteps, [], 3);
end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
