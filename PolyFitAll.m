function mOut = PolyFitAll(x, mIn, iOrder)

% mOut = PolyFitAll(x, mIn, iOrder);
%
% polyfit a matrix
%
% Khan 04/01/2010

%% Default params


%% Initialize
nRows = size(mIn, 1);
mOut = zeros(nRows, iOrder + 1);

%% Main
for iRow = 1:nRows
    mOut(iRow, :) = polyfit(x(:), mIn(iRow, :), iOrder);
end


end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
