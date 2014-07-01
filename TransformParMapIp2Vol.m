function oVolume = TransformParMapIp2Vol(oInplane, oVolume, bForceSave)
% TransformParMapIp2Vol;
%
%
%
% Khan 07/12/2011

mrGlobals

%% Default params
if notDefined('oInplane'); oInplane = getSelectedInplane; end
if notDefined('oVolume');  oVolume  = getSelectedVolume;  end
if notDefined('bForceSave'), bForceSave = true; end

%% Initialize

%% Main

	oVolume = switch2Vol(oVolume);

	oVolume = ip2volParMap(oInplane, oVolume, 0, bForceSave, 'linear'); 
	oVolume = setDisplayMode(oVolume, 'map'); 
	oVolume = refreshScreen(oVolume, 1); 

end %function

%% Note: type "doc hungarian" for variable prefix explanation.
