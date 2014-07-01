function mDMatrix = mDMatrix(fTR, fBeta, fT1, fT2)

%fBeta = fBeta * pi / 180;

fE1 = exp(-fTR/fT1);
fE2 = exp(-fTR/fT2);

mDMatrix(1,1) = fE2*cos(fBeta);
mDMatrix(1,2) = fE2*sin(fBeta);
mDMatrix(1,3) = 0;

mDMatrix(2,1) = -fE2*sin(fBeta);
mDMatrix(2,2) = fE2*cos(fBeta);
mDMatrix(2,3) = 0;

mDMatrix(3,1) = 0;
mDMatrix(3,2) = 0;
mDMatrix(3,3) = fE1;

end