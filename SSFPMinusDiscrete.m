function SteadyStateMagnitudeOfTransverseComponent = SSFPDiscrete(fTR, fAlpha, fT1, fT2, fBeta, iIterations)

% Rez - Sept. 2008.

%% Initialization
vZHat = [0 0 1]';
fM0 = 1;

vMMinus = fM0*vZHat;
mData = vMMinus;

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
if ~exist('iIterations', 'var')
    iIterations = 200;
end
if ~exist('fT2', 'var')
    fT2 = 0.2;
end
if ~exist('fT1', 'var')
    fT1 = 1;
end

%% Initial half-angle flip
%M^+(n) = R_x(theta) M^-(n); eq. 18.49 Haacke
vMPlus = mRx(-fAlpha/2) * vMMinus;

% plot data
mData = horzcat(mData, vMPlus);

%% Flip Loop
for iN = 1:iIterations
    % evolution/relaxation
    %M^-(n+1) = D(TR) M^+(n) + M_0(1-E_1) zHat; eq. 18.50 Haacke
    vMMinus = vEvolveMMinus(fTR, fBeta, fT1, fT2, fM0,vMPlus);

    % acquire data
    mData = horzcat(mData, vMMinus);

    % alpha flip
    %M^+(n) = R_x(theta) M^-(n); eq. 18.49 Haacke
    vMPlus = mRx(fAlpha) * vMMinus;

    % acquire data
    %mData = horzcat(mData, vMPlus);

    % evolution/relaxation
    %M^-(n+1) = D(TR) M^+(n) + M_0(1-E_1) zHat; eq. 18.50 Haacke
    vMMinus = vEvolveMMinus(fTR, fBeta, fT1, fT2, fM0,vMPlus);

    % acquire data
    mData = horzcat(mData, vMMinus);

    % +alpha flip
    %M^+(n) = R_x(theta) M^-(n); eq. 18.49 Haacke
    vMPlus = mRx(-fAlpha) * vMMinus;

    % acquire data
    mData = horzcat(mData, vMPlus);
    
end

%% Plot data
   plot(abs(mData(2,:)));
   %plot(mData(2,:),mData(3,:));
   
%% Output
SteadyStateMagnitudeOfTransverseComponent = abs(mData(2,end));

end