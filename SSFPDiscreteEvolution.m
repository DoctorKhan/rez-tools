function vMagnitudeOfTransverseComponent = SSFPDiscreteEvolution(fTR, fAlpha, fT1, fT2, fBeta, iIterations)

% Rez - Sept. 2008.

%% Initialization
vZHat = [0 0 1]';
fM0 = 1;

vMMinus = fM0*vZHat;
mMinusData = vMMinus;

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
if ~exist('iIterations', 'var')
    iIterations = 1000;
end
if ~exist('fT2', 'var')
    fT2 = 0.099;
end
if ~exist('fT1', 'var')
    fT1 = 1.820;
end

%% Initial half-angle flip
%M^+(n) = R_x(theta) M^-(n); eq. 18.49 Haacke
vMPlus = mRx(fAlpha/2) * vMMinus;

% plot data
mPlusData = vMPlus;

%% Flip Loop
for iN = 1:iIterations
    % evolution/relaxation
    %M^-(n+1) = D(TR) M^+(n) + M_0(1-E_1) zHat; eq. 18.50 Haacke
    vMMinus = vEvolveMMinus(fTR, fBeta, fT1, fT2, fM0,vMPlus);

    % acquire data
    mMinusData = horzcat(mMinusData, vMMinus);

    % -alpha flip
    %M^+(n) = R_x(theta) M^-(n); eq. 18.49 Haacke
    vMPlus = mRx(-fAlpha) * vMMinus;

    % acquire data
    mPlusData = horzcat(mPlusData, vMPlus);

    % evolution/relaxation
    %M^-(n+1) = D(TR) M^+(n) + M_0(1-E_1) zHat; eq. 18.50 Haacke
    vMMinus = vEvolveMMinus(fTR, fBeta, fT1, fT2, fM0,vMPlus);

    % acquire data
    mMinusData = horzcat(mMinusData, vMMinus);

    % +alpha flip
    %M^+(n) = R_x(theta) M^-(n); eq. 18.49 Haacke
    vMPlus = mRx(fAlpha) * vMMinus;

    % acquire data
    mPlusData = horzcat(mPlusData, vMPlus);

end

%% Plot data
%plot(vTransverse(mMinusData)); pause;
%plot(vTransverse(mPlusData)); pause;
%plot(mPlusData(2,:), mPlusData(3,:)); pause;
%plot(mMinusData(2,:), mMinusData(3,:));

%% Output
vMagnitudeOfTransverseComponent = vTransverse(mPlusData);

end