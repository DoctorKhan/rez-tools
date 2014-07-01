function tbSeed = FloodFill3D(tVol, vPoint, iMax)

% FloodFill3D;
%
%
%
% Khan 04/17/2010

%% Default params
if notDefined('iMax'), iMax = 1000; end

%% Initialize
tbGray = isfinite(tVol);
tbSeed = false(size(tbGray));
tbSeed(vPoint) = true;

%% Main

nVoxels = 1;

for ii = 1:iMax
    [ii nVoxels]
    % 1. Find points without domain neighpors
    nVoxelsOld = nVoxels;
    
    for iDir = 1:6
        vDir = CubePts(iDir);
        
        tP1 = tbSeed & ~circshift(tbSeed, -vDir');
        tP2 = circshift(tP1, vDir');
        tP2 = tP2 & ~tbGray;
        
        tbSeed = tbSeed | tP2;
        
    end
    
        nVoxels = sum(tbSeed(:));
    
    if nVoxels == nVoxelsOld
        break;
    end
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
