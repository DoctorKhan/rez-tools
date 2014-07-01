function xOut = sdiff(x, iDim)

% xOut = sdiff(x, iDim);
%
%
%
% Khan 04/25/2012

%% Default params
Default iDim = 1

%% Initialize
viDim = size(x);

%% Main
if iDim > 0
    d = diff(x,1,iDim);
    viDim(iDim) = 1;
    xOut = cat(iDim, nan(viDim), d);
else
    iDim = -iDim;
    d = diff(x,1,iDim);
    viDim(iDim) = 1;
    xOut = cat(iDim, d, nan(viDim));
end


end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
