function SteadyStateVsBeta = SteadyStateVsBeta(fTR, fAlpha, fT1, fT2, iIterations, fBetaMin, fBetaMax, fBetaIncrement)

%% Overloading
if ~exist('fTR', 'var')
    fTR = 0.02 ;
end
if ~exist('fAlpha', 'var')
    fAlpha = pi/3 ;
end
if ~exist('fBetaMin', 'var')
    fBetaMin = - 1.11 * pi ;
end
if ~exist('fBetaMax', 'var')
    fBetaMax = 1.11 * pi;
end
if ~exist('fBetaIncrement', 'var')
    fBetaIncrement = pi / 180;
end
if ~exist('iIterations', 'var')
    iIterations = 100;
end
if ~exist('fT2', 'var')
    fT2 = 0.2;
end
if ~exist('fT1', 'var')
    fT1 = 1;
end

%% Loop
for fBeta = fBetaMin:fBetaIncrement:fBetaMax
    % Create initial data point, if necessary
    if ~exist('mData', 'var')
        mData = [fBeta, SSFPDiscrete(fTR, fAlpha, fT1, fT2, fBeta, iIterations)]';
    else
        %acquire data
        mData = horzcat(mData, [fBeta, SSFPDiscrete(fTR, fAlpha, fT1, fT2, fBeta, iIterations)]');
    end
end

SteadyStateVsBeta = mData;

end
