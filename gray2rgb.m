function [tRGB, maxScale, minShift, maxVal] = gray2rgb(mImage)

% [tRGB, maxScale, minShift] = gray2rgb(mImage);
%
% First rescale matrix between 0 and 1 and then convert to rgb tMatrix.
%
% Khan 12/26/2010

%% Default params


%% Initialize


%% Main
[mImage, maxScale, minShift, maxVal] = RescaleMat(mImage);
tRGB = repmat(mImage, [1 1 3]);

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
