function vNormalizedTimeSeries = NormalizedTimeSeries(vTimeSeries, iFirstSSFrame)

% vNormalizedTimeSeries = NormalizedTimeSeries(vTimeSeries, iFirstSSFrame);
%
% Bogus.
%
% Khan
%%
iLastFrame = length(vTimeSeries);

if ~exist('iFirstSSFrame', 'var')
    iFirstSSFrame = floor(iLastFrame*0.8);
end

%%
SS = mean(vTimeSeries(iFirstSSFrame:iLastFrame));
vNormalizedTimeSeries = vTimeSeries/SS;

if ~exist('mNormTimeSeries', 'var')
    
end

%% Note: type "doc hungarian" for variable prefix explanation.
