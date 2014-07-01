function mCoords = phys2mat(mCoords, fov, mmPerVox)

% mat = phys2mat(mCoords, fov, N);
%
% Physical to matlab unit conversion
%
% Khan 05/20/2011

%% Default params


%% Initialize
if isMesh(mCoords)
    Destruct mCoords
    mCoords = vertices;
    try fov = oMesh.fov; end
end

% if isscalar(fov), fov = repmat(3, 1, fov); end
% if isscalar(mmPerVox), mmPerVox = repmat(mmPerVox, [3, 1]); end

%% Main
if all(mCoords(:)) > 0, return; end
mCoords = MatrixVectorSum(mCoords, fov/2);
mCoords = MatrixVectorDiv(mCoords, mmPerVox);

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
