function SteadyStateMagnitudeOfTransverseComponent = SSFPMinusInfinity(fTR, fAlpha, fT1, fT2, fBeta, iIterations)

% Rez - Sept. 2008.

%% Overloading
if ~exist('fTR', 'var')
    fTR = 0.02 ;
end
if ~exist('fAlpha', 'var')
    fAlpha = pi/3 ;
end
if ~exist('fBeta', 'var')
    fBeta = 0;
end
if ~exist('fT2', 'var')
    fT2 = 0.2;
end
if ~exist('fT1', 'var')
    fT1 = 1;
end

%% Initialization
vZHat = [0 0 1]';
fM0 = 1;
fE1 = exp(-fTR/fT1);

%% Final Steady State
%M^-(inf) = (I - D(T_R)R_x(theta))^-1 M_0(1-E_1) zHat; eq. 18.52 Haacke
vMMinus = (eye(3) - mDMatrix(fTR, fBeta, fT1, fT2)*mRx(fAlpha))^-1 * fM0*(1-fE1) * vZHat;
   
%% Output
SteadyStateMagnitudeOfTransverseComponent = vMMinus(2);

end