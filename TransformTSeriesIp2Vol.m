function oVol = TransformTSeriesIp2Vol(oVol, oInp)

% oVol = TransformTSeriesIp2Vol(oInp, oVol);
%
%
%
% Khan 07/11/2011

mrGlobals

%% Default params
if notDefined('oInp');
    dt = dataTYPES(oVol.curDataType);
    oInp = initHiddenInplane(dt);
    oInp.curDataType = oVol.curDataType;
end

%% Initialize


%% Main
oVol = ip2volTSeries(oInp, oVol, 0, 'linear');

end %function


%% Note: type "doc hungarian" for variable prefix explanation.
