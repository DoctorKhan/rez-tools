function mXY = ComplexGrid(nCols, nRows)

%
% mXY = ComplexGrid(nCols, nRows);
%
% 
%
% Khan 10/09
%

%% Default params
if ~exist('nRows', 'var'), nRows = nCols; end

%% Main
vx = (1:nCols) - (nCols+1)/2;
vy = (1:nRows) - (nRows+1)/2;
%vy = -vy;

[mX, mY] = meshgrid(vx, vy);

%normFac = max([abs(mX(:)); abs(mY(:))]);
%mX = mX/normFac; mY = mY/normFac;

mXY = mX + i*mY;

end
