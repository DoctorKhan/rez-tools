function moResults = LamHRFTransAll(voSubs, voROIs, voCNRs, oView1, nBoots, sOption)

% moResults = LamHRFAll(voSubs, voROIs, voCNRs, voBins, oView1, nBoots, sOption);
%
%
%
% Khan 07/26/2011

%% Initialize
close all;
diary on
linux date
HemoInit

% Defaults to all
Default viScans | nBoots = 1200;

[voAllBins viBins] = BinBounds(.15,.25); %#ok<NASGU,ASGLU>
Default voBins = voAllBins(viBins)

%
voSubs = NumStruct(voSubs);
voROIs = NumStruct(voROIs);
voCNRs = NumStruct(voCNRs); % 60

%
nROIs = length(voROIs);
nCNRs = length(voCNRs);
nSubs = length(voSubs);

Default sOption = "Load"

moResults = cell(nSubs, nROIs, nCNRs);
Default oView1

%% Main
for oSub = voSubs
	% Initialize
	clear global
	cds('-v', oSub)
	
	view = InitHidden('Volume', 'Timed', viScans, oView1, sOption);
	ts = view.tsSliceBlock;
	
	[view, oMaps] = NormalizedDepthMap(view);
	vNormMap = oMaps.vNormMap;
	
	% Bootstrap indices
	nTrials = size(ts, 2);
	mResampTrans = reshape(randsample(nTrials, nBoots*nTrials, 'true'), nTrials, nBoots);
	Save('BootstrapIndices', mResampTrans, 'append');

	oROI = Load(SessionDir('Gray', 'ROIs', V14pu50.name));
	LamHRFTrans(view, oROI, ts, vNormMap, mResampTrans);
	
	mrVistaClose;
	oView1 = [];
end

%% Logging
linux date
diary off

end %function

%% Note: type "doc hungarian" for variable prefix explanation.
