function m = FillHoles2D(m, iDColor, nIter)

% m = FilleHoles2D(m, iDColor, nIter);
%
%
%
% Khan 12/09/2009

% vSize = size(m);
% nCols = vSize(2);

% mUL = circshift(m, [-1  1]);
% mDL = circshift(m, [-1 -1]);
% mUR = circshift(m, [ 1  1]);
% mDR = circshift(m, [ 1 -1]);

for iIter = 1:nIter
    mL  = circshift(m, [-1  0]);
    mR  = circshift(m, [ 1  0]);
    mU  = circshift(m, [ 0  1]);
    mD  = circshift(m, [ 0 -1]);

    m(~m & mU & mD & ((mU == iDColor) | (mD == iDColor))) = iDColor;
    m(~m & mL & mR & ((mL == iDColor) | (mR == iDColor))) = iDColor;

    % Fill corners
    m(~m & (mU == iDColor) & ((mL == iDColor) | (mR == iDColor))) = iDColor;
    m(~m & (mD == iDColor) & ((mL == iDColor) | (mR == iDColor))) = iDColor;
end

end
