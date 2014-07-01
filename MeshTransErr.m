function m = MeshTransErr(vAdj, oMesh, oVolume)

% m = MeshTransErr(vAdj, mCoords, varargin);
%
% Only pass oMesh and oVolume once.
%
% Khan 04/24/2012

%% Default params

%% Initialize
persistent vCoords vInit tData

%% Main
if exist('oVolume', 'var')
    % Initialize
    if isMesh(oMesh)
        vInit = oMesh.vertices;
    else
        vInit = oMesh;
    end
    vCoords = vInit;
    tData = oVolume;
end

vCoords(1,:) = vInit(1,:) + vAdj(1);
vCoords(2,:) = vInit(2,:) + vAdj(2);
vCoords(3,:) = vInit(3,:) + vAdj(3);

vInt = abs(LinearInterp(tData, vCoords));
if fin(vInt) < 95
    m = Inf;
    s = Inf;
else
    [m s] = mss(vInt);
end
Str('Current error:', m, '+/-', s, Tab, 'Current adjustment:', vAdj);

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
