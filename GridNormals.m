function oPts = GridNormals(oPts, oMesh, varargin)

% oPts = GridNormals(oPts, oMesh, varargin);
%
%
%
% Khan 04/12/2012
 
%% Default params
Default nProcs = 6;

%% Initialize


%% Main

nPts = length(oPts.vertices);
nSubs = floor(nPts/nProcs);

for ii = 1:nProcs
    oSubPts = RawMesh(oPts);
    vbGood = false(1, nPts);
    
    iLast = ii*nSubs;
    iFirst = iLast - nSubs + 1;
    if iLast > nPts, iLast = nPts; end
    vbGood(iFirst:iLast) = true;
    oSubPts.vbGood = vbGood;
    oSubPts.Truncate;
    voSubs(ii) = RawMesh(oSubPts);
end % Function

parfor ii = 1:nProcs
    voSubs(ii) = GridMeshNorm(voSubs(ii), oMesh, varargin);
end

for ii = 1:nProcs
    oPts.normals(:,voSubs(ii).vbGood) = voSubs(ii).normals;
end
 
%% Note: type "doc hungarian" for variable prefix explanation.
