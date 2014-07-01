function mRx = mRx(fTheta)

%fTheta = fTheta * pi / 180;

mRx(1,1) = 1;
mRx(1,2) = 0;
mRx(1,3) = 0;

mRx(2,1) = 0;
mRx(2,2) = cos(fTheta);
mRx(2,3) = sin(fTheta);

mRx(3,1) = 0;
mRx(3,2) = -sin(fTheta);
mRx(3,3) = cos(fTheta);

end