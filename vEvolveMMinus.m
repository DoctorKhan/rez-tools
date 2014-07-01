function vEvolveMMinus = vEvolveMMinus(fTR, fBeta, fT1, fT2, fM0, vMPlus)

% evolution/relaxation
%M^-(n+1) = D(TR) M^+(n) + M_0(1-E_1) zHat; eq. 18.50 Haacke

fE1 = exp(-fTR/fT1);
vZHat = [0 0 1]';

vEvolveMMinus = mDMatrix(fTR, fBeta, fT1, fT2) * vMPlus + fM0*(1-fE1) * vZHat;

end