% TestCalcInitDip;
%
%
%
% Khan 09/23/2011

%% Default params


%% Initialize


%% Main
for ii = 1:3
[vY, vT] = SampleHRF(ii);
[~, ~, iDipTime] = CalcInitDip(vT, vY);
figure
PlotWithMarkers(vT, vY, iDipTime);
end
%% Note: type "doc hungarian" for variable prefix explanation.
