function [viIndices, viDim] = log2ind3d(tbMatrix)

% [viIndices, viDim] = log2ind3d(tbMatrix);
% 
% Return 1-d indices of logical tMatrix;
% 
% Khan 02/12/2010

%% Default params

%% Initialize
viDim = size(tbMatrix);

%% Main
viIndices = find(tbMatrix(:));

end %function