% function Figures1Sub

% Figures1Sub;
%
%
%
% Khan 10/18/2011

%% Default params


%% Initialize


%% Main

voExtra = HorzVec(dir('Boot*-LaminarExtra*u50.mat'));
voStrC = HorzVec(dir('Boot*-LaminarV1dvc*u50.mat'));
voStrT = HorzVec(dir('Boot*-LaminarV1dvt*u50.mat'));

for oFile = [voExtra voStrC voStrT]
	FiguresHRF(oFile)
end


%%
FiguresHRF('BootHRFAnalysis-LaminarVDpu50.mat')
FiguresHRf('BootHRFAnalysis-LaminarVVpu50.mat')

% voBoot*-V1pu50.mat

% end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
