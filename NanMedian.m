function xMedianOut = NanMedian(xVectorIn, iDim)

% xMedianOut = NanMedian(xVectorIn);
%
%	Mathworks' version doesn't actually work from what I can tell, so I
%	wrote this one.
%
%   M = NANMEDIAN(X) returns the sample median of X, treating NaNs as
%   missing values.  For vector input, M is the median value of the non-NaN
%   elements in X.  For matrix input, it converts it to a vector first.
%
%   See also MEDIAN, NANMEAN, NANSTD, NANVAR, NANMIN, NANMAX, NANSUM.
%   Copyright 1993-2004 The MathWorks, Inc.
%   $Revision: 2.12.2.2 $  $Date: 2004/01/24 09:34:33 $%
%
% Khan 12/20/2011

Default iDim = 1
%% Main
xVectorIn(isnan(xVectorIn)) = [];
v = VertVec(double(xVectorIn));
xMedianOut = prctile(v, 50);
% iDim);
if isempty(xMedianOut), xMedianOut = nan; end

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
