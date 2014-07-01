function SteadyStateVsBeta = SteadyStateVsBeta(fTR, fAlpha, fT1, fT2, iIterations, fBetaMin, fBetaMax, fBetaIncrement)

%
% SteadyStateVsBeta = SteadyStateVsBeta(fTR, fAlpha, fT1, fT2, iIterations, fBetaMin, fBetaMax, fBetaIncrement);
%
% 
%
% Khan  03/31/09
%

%% Default params
if ~exist('fTR', 'var')
    %fTR = 0.0089;
    fTR = 0.360 / 8;
end
if ~exist('fAlpha', 'var')
    fAlpha = 20*pi/180 ;
end
if ~exist('fBetaMin', 'var')
    fBetaMin = - 2 * pi ;
end
if ~exist('fBetaMax', 'var')
    fBetaMax = -fBetaMin;
end
if ~exist('fBetaIncrement', 'var')
    fBetaIncrement =  0.33*pi / 180;
end

if ~exist('iIterations', 'var')
    iIterations = 1000;
end
if ~exist('fT2', 'var')
    %fT2 = 0.099;
    fT2 = 0.067; % (s) for phantom
end
if ~exist('fT1', 'var')
    %fT1 = 1.820;
    fT1 = 0.87; % (s) for phantom
end
%% Loop
figure
oBetaWaitBar = waitbar(0, 'Please wait...' );
mData = zeros(3,length(fBetaMin:fBetaIncrement:fBetaMax));
for fBeta = fBetaMin:fBetaIncrement:fBetaMax
    fProgress = (fBeta-fBetaMin)/(fBetaMax-fBetaMin);
    waitbar(fProgress,oBetaWaitBar, ['Acquiring Mxy(Beta) for ', num2str(fAlpha*180/pi), ' degrees']);
    [SteadyStateMagnitudeOfTransverseComponent, vMagnitudeOfTransverseComponent, SteadyStatePhase] = SSFPDiscrete(fTR, fAlpha, fT1, fT2, fBeta, iIterations);
    vNewData = [fBeta; SteadyStateMagnitudeOfTransverseComponent; SteadyStatePhase];
    % Create initial data point, if necessary
    if (fBeta == fBetaMin)
        mData = vNewData;
    else
        %acquire data
        %first row is x-data
        %second row is y-data
        mData = [mData, vNewData];
    end
    %plot
    plotData(mData);
end
    mPhase = [mData(1,:); mData(3,:)];
    figure
    plotData(mPhase);

close(oBetaWaitBar);

SteadyStateVsBeta = mData;

end
