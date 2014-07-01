function MeanEventsSingle(sSession)

% MeanEventsSingle(sSession);
%
% Depth Averages and AverageSessionEvents
%
% Khan 07/12/2011

%% Initialize
mrGlobals
close all

scanList = 0;
%% Main
% Go to session dir
cds(sSession);
mrVista Gray; % mrVista('Inplane');

% Delete all datatypes after Timed
while ~strcmp(dataTYPES(end).name, 'Timed')
        removeDataType(dataTYPES(end).name, 0);
end
    
% Switch to Timed data type.
oGray = selectDataType(getSelectedGray, 'Timed'); 

% Depth Avg Time Series
oGray = AddDepthAvgTSeries(oGray, scanList, [0, 4]); 

% Average all timed scans together:
oGray = averageTSeries(oGray, scanList);
	
% Mean Events (CNR)
oGray = selectDataType(oGray, 'Timed');
oInfo = HRFInfo('', sSession);
AverageSessionEvents(oInfo.period, 0, oGray);

% Close mrVista
close all;

end %function
%% Note: type "doc hungarian" for variable prefix explanation.

% Original, MotionComp, MotionComp_RefScan1, Timed, Averages, DepthAvgTSeries, MeanEvents
