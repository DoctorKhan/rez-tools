function m = FillCorners2D(m, iDColor)

% m = Dilate2D(m, iDColor, nIter);
%
%
%
% Khan 12/09/2009

m1 = circshift(m, [-1 0]);
m2 = circshift(m, [1 0]);
m3 = circshift(m, [0 -1]);
m4 = circshift(m, [0 1]);
mbFill = (m1 & m2 & m3 & m4) & ~m;
m(mbFill) = iDColor;

end
