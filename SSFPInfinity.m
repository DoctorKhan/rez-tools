function [SteadyStateMagnitudeOfTransverseComponent, SteadyStatePhase] = SSFPInfinity(fTR, fAlpha, fT1, fT2, fBeta)
% Angle in radians
% Rez - Sept. 2008.

%% Overloading
if ~exist('fTR', 'var')
    fTR = 0.0089 ;
end
if ~exist('fAlpha', 'var')
    fAlpha = 20*pi/180 ;
end
if ~exist('fBeta', 'var')
    fBeta = 0;
end
if ~exist('fT2', 'var')
    fT2 = 0.099;
end
if ~exist('fT1', 'var')
    fT1 = 1.820;
end

%% Initialization
vZHat = [0 0 1]';
fM0 = 1;
fE1 = exp(-fTR/fT1);

%% Final Steady State
%M^+(n) = R_x(theta) (I - R_x(theta)D(T_R))^-1 M_0(1-E_1) zHat; eq. 18.53 Haacke
vMPlus = (eye(3) - mRx(fAlpha)*mDMatrix(fTR, fBeta, fT1, fT2))^-1 * mRx(fAlpha) * fM0*(1-fE1) * vZHat;
   
%% Output
SteadyStateMagnitudeOfTransverseComponent = vTransverse(vMPlus);
SteadyStatePhase = atan(vMPlus(2) / vMPlus(1));
if (SteadyStatePhase < 0), SteadyStatePhase = SteadyStatePhase + pi;
end