function fSfit = DFFit(firstarg, dte, iScan)

%
% fSfit = DFFit(firstarg, dte);
%
% Returns a fit structure containing relevant fit data.
% The first argument is the path of the data.
%
% Khan  03/18/09
%

%% Default arguments
if ~exist('dte', 'var'), dte = 0.002; end
if ~exist('iScan', 'var'), iScan = 1; end

if ~exist('firstarg', 'var')
    firstarg = 'warm';
end

%% Argument handling
if ists(firstarg)
    % Assume it is the complex time series
    ts = firstarg;
end

if isstruct(firstarg)
    % Assume it is a DF fit structure
    ts = firstarg.ts;
    dte = firstarg.dte;
end

if ischar(firstarg)
    disp(['Loading complex time series ', firstarg]);
    ts = GetComplexTimeSeries(firstarg, iScan);
end

%ts = GetComplexTimeSeries('/mnt/proj/vision/MRI/SSFP/DynamicMapping/Raw');
% Cold scanner:
%ts = GetComplexTimeSeries('/mnt/proj/vision/MRI/Raw/011409rk/Raw');
% Warm scanner:  '/mnt/proj/vision/MRI/Raw/021609szDF/Raw';

%% main routine
% These are the fieldmaps constructed by comparing t and t + dte.
disp(['Making the fieldmaps. ']);
tsFieldMaps = MakeFieldMaps(ts, dte);

% This gets the linear fit coefficients A, B, C in Ax + By + C = dw.
% mMask is a vector containing 1's and 0's indicating whether an element
% should be ignored because it is NaN (0), or considered (1) for
% statistical calculations.
[mFitParams, mMask, tsWeights] = GetLinearFitParams(tsFieldMaps, ts);

fSfit.mFitParams = mFitParams;
fSfit.ts = ts;
fSfit.tsFieldMaps = tsFieldMaps;
fSfit.tsFieldMapsWtd = tsFieldMaps .* tsWeights;
fSfit.tsWeights = tsWeights;
fSfit.dte = dte;

end
