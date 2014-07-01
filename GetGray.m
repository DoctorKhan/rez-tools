function [tGrayBoth, tGrayLeft, tGrayRight] = GetGray(sSubject, sRegion, sType)

% [tGrayBoth, tGrayLeft, tGrayRight] = GetGray(sSubject, sRegion, sType);
%
% Gets the gray segmentation
%
% Khan 07/02/2010

%% Default params
if notDefined('sSubject'), sSubject = 'Khan'; end
if notDefined('sRegion'), sRegion = 'Cortex'; end
if notDefined('sType'), sType = ''; end

%% Initialize
% Get paths
[pGrayLeft, pGrayRight] = GetAnatomyPaths(sSubject, sRegion, sType);

%% Main


% Read Gray
mGrayL = readGrayGraph(pGrayLeft);
[mGrayR, ~, viDims] = readGrayGraph(pGrayRight);

% Combine Gray
tGrayLeft = sub2log3d(mGrayL, viDims);
tGrayRight = sub2log3d(mGrayR, viDims);
tGrayBoth = tGrayLeft | tGrayRight;

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
