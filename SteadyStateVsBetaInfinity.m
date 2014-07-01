function [SteadyStateVsBeta, mData] = SteadyStateVsBetaInfinity(fTR, fAlpha, fT1, fT2, iIterations, fBetaMin, fBetaMax, fBetaIncrement)

%
% [SteadyStateVsBeta, mData] = SteadyStateVsBetaInfinity(fTR, fAlpha, fT1, fT2, iIterations, fBetaMin, fBetaMax, fBetaIncrement);
%
% 
%
% Khan  03/31/09
%

%% Overloading
if ~exist('fTR', 'var')
    fTR = 0.0089;
end
if ~exist('fAlpha', 'var')
    fAlpha = 20*pi/180 ;
end
if ~exist('fBetaMin', 'var')
    fBetaMin = - 2 * pi ;
end
if ~exist('fBetaMax', 'var')
    fBetaMax = 2 * pi;
end
if ~exist('fBetaIncrement', 'var')
    fBetaIncrement = .33 * pi / 180;
end
if ~exist('fT2', 'var')
    fT2 = 0.099;
end
if ~exist('fT1', 'var')
    fT1 = 1.820;
end

%% Loop
for fBeta = fBetaMin:fBetaIncrement:fBetaMax
    % Create initial data point, if necessary
    if ~exist('mData', 'var')
        mData = [fBeta, SSFPInfinity(fTR, fAlpha, fT1, fT2, fBeta)]';
    else
        %acquire data
        mData = horzcat(mData, [fBeta, SSFPInfinity(fTR, fAlpha, fT1, fT2, fBeta)]');
    end
end

%plot
plotData(mData)

SteadyStateVsBeta = mData;

end
