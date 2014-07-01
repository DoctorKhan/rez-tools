function tData = ReadDumpIntoVolume(pFile, viDim, nHeaderLines)

% tData = ReadDumpIntoVolume(pFile, viDim, nHeaderLines);
%
%
%
% Khan 02/18/2012
 
%% Default params


%% Initialize
pOut = FileExt(pFile, '.mat');
Default nHeaderLines = 0;

%% Main
linux('/home/khan/bin/dmp2mat', pFile, pOut);
load(pOut);

if notDefined('viDim')
    nDataIn = length(data)-nHeaderLines;
    nRoot = round(nDataIn^(1/3));
    viDim = repmat(nRoot, 1, 3);
end

nDataOut = prod(viDim);
viDataOut = (1:nDataOut) + nHeaderLines;
tData = reshape(data(viDataOut), viDim);

rm(pOut);

end

% pFilename = ForcExt(pFile, '.rawiv');
% vBoundingBox = str2double(regexp(linux(['volinfo ', pFilename, ' | grep Bound | cut -d : -f 2 | sed "s,[^0-9.], ,g" ']), ' ', 'split'));
% vScale = str2double(regexp(linux(['volinfo ', pFilename, ' | grep Span | cut -d : -f 2 | sed "s,[^0-9.], ,g" ']), ' ', 'split'));
% vScale(isnan(vScale)) = [];
% 
% vBoundingBox(isnan(vBoundingBox)) = [];
% mBB(1,:) = vBoundingBox(1:3);
% mBB(2,:) = vBoundingBox(4:6);
% 
% % viDimMRC = str2double(regexp(linux(['volinfo ', pFilename, ' | grep Dimension | cut -d " " -f 2']), 'x', 'split'));
% % [viDimMRC(1), viDimMRC(2)] = swap(viDimMRC(1), viDimMRC(2));
% 
% % [mBB(:,1), mBB(:,2)] = swap(mBB(:,1), mBB(:,2));
% 
% s.bbox = mBB;
% s.voxelSize = vScale;
% 
% %% Load map into output structure
% s.vol = map;
% s.dim = [s.nx s.ny s.nz];
% 
% viDimSmall = size(s.vol);
% miSmall = log2sub3d(ones(viDimSmall));
% 
% vOriginShift = round((s.bbox(1,:)./s.voxelSize));
% miBig = repmat(vOriginShift', [1 size(miSmall, 2)]) + miSmall;
% 
% viBig = sub2ind3d(miBig, viDim);
% tVolume = zeros(viDim);
% tVolume(viBig) = s.vol(:);
% 
% cent(tVolume);
% 
% % end % Function
% 
%  
% %% Note: type "doc hungarian" for variable prefix explanation.
