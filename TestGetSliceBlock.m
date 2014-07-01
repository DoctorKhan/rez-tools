

% TestGetSliceBlock;
%
%
%
% Khan 07/21/2011

%% Default params


%% Initialize


%% Main

% [tsInROI, mROICoords, viMask] = LoadTSeriesInROI;

t = GetSliceBlock(oView, oView.coords(:,50000:100000),1);

GetSliceBlock;

max(t(:))
o = load('SliceBlock');
max(o.tsSliceBlock(:))

%% Note: type "doc hungarian" for variable prefix explanation.
