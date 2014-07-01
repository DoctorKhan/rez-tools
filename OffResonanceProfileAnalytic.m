function [mDataTransverseMag, mDataPhase] = OffResonanceProfileAnalytic(fTR, fAlpha, fT1, fT2, fBetaMin, fBetaMax, fBetaIncrement)

%
% [SteadyStateVsBeta, mData] = SteadyStateVsBetaInfinity(fTR, fAlpha, fT1, fT2, iIterations, fBetaMin, fBetaMax, fBetaIncrement);
%
% 
%
% Khan  03/31/09
%

%% Default params (for phantom #3)
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
    fBetaMax = 2 * pi;
end
if ~exist('fBetaIncrement', 'var')
    fBetaIncrement =  0.33*pi / 180;
end

if ~exist('fT2', 'var')
    %fT2 = 0.099;
    fT2 = 0.067; % (s) for phantom
end
if ~exist('fT1', 'var')
    fT1 = 0.87; % (s) for phantom
end

%% Loop
for fBeta = fBetaMin:fBetaIncrement:fBetaMax
    [transverseMag, phase] = SSFPInfinity(fTR, fAlpha, fT1, fT2, fBeta);
    % Create initial data point, if necessary
    if ~exist('mDataTransverseMag', 'var')
        mDataTransverseMag = [fBeta, transverseMag]';
        mDataPhase = [fBeta, phase]';
    else
        %acquire data
        mDataTransverseMag = horzcat(mDataTransverseMag, [fBeta, transverseMag]');
        mDataPhase = horzcat(mDataPhase, [fBeta, phase]');
    end
end

end
