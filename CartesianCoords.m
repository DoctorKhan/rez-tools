function [tX tY tZ cvGridPts] = CartesianCoords(tIn, vCenter)

% [tX tY tZ cvGridPts] = CartesianCoords(tIn, vCenter);
%
%
%
% Khan 02/06/2012
 
%% Default params
Default vCenter = [0 0 0];

%% Initialize
viDim = size(tIn);
cvGridPts = cell(1,3);

%% Main
for ii = 1:3
	cvGridPts{ii} = (1:viDim(ii)) - vCenter(ii);
end

[tX tY tZ] = meshgrid(cvGridPts{:});

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
