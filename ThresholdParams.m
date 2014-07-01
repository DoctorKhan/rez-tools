function oParams = ThresholdParams(oParams)

% ThresholdParams(oParams);
%
%
%
% Khan 09/14/2011

%% Default params


%% Initialize


%% Main
maxVal = 8*NanMean2(oParams.PeakValue);

t(1,:,:)  = oParams.InitialDipValue;
t(2,:,:)  = oParams.PeakValue;
t(3,:,:)  = oParams.UndershootValue;

t(abs(t) > maxVal) = nan;

oParams.InitialDipValue = squeeze(t(1,:,:));
oParams.PeakValue = squeeze(t(2,:,:));
oParams.UndershootValue = squeeze(t(3,:,:));

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
