function LamHRFAll(voSubs, voROIs, voBins, oView1, nBoots, sOption)

% LamHRFAll(voSubs, voROIs, voBins, oView1, nBoots, sOption);
%
% Over all subjects and ROIs.
%
% Khan 07/26/2011

HemoInit
%% Defaults
Default sOption = "Load" & oView1 & viScans % Defaults to all
Default voSubs = voHemo & voROIs = voBaseROIs & voCNRs = voCNRSet(2)
% CNR = uppper 50%

%% Initialize
close all; diary on; linux date

% Lengths
nROIs = voROIs.nTot; voFailed = [];

%% Main
for oSub = voSubs
	% Initialize
	clear global; clear oView;
	cds('-v', oSub)
	
	oView = InitHidden('Volume', 'Timed', viScans, oView1, sOption);
	oView = loadAnat(oView);
	ts = oView.tsSliceBlock;
	
	[oView, oMaps] = NormalizedDepthMap(oView, oSub, 'load');
	vNormMap = oMaps.vNormMap;
	
	% Bootstrap indices
	nTrials = size(ts, 2);
	mResamp = reshape(randsample(nTrials, nBoots*nTrials, 'true'), nTrials, nBoots);
	Save('BootstrapIndices', mResamp, '-append');
	
	for oROI = voROIs
		oROI.name = [oROI.name 'u50'];
		TextWaitbar(oROI.iNum/nROIs, Str('ROI:', oROI.name));
		% Load ROI
		disp(['Loading ROI ', oROI.name, '...']);
		
		oView.ROIs = Load(SessionDir('Gray', 'ROIs', oROI));
		oView.selectedROI = 1;
		
		if isempty(oView.ROIs) || isempty(oView.ROIs(end).coords)
			disp('Empty ROI');
			continue
		end
		% try
		[~, oView] = MarkLaminarROI(oView);
				
		csFields = {'viewType', 'created', 'modified', 'coords'};
		oView.ROIs = CopyStruct(oView.ROIs(1), oView.ROIs(2), csFields);
		oView = RestrictROI2Vol(1, oView);

		LamHRF(oView, 1, voBins, ts, vNormMap, mResamp);
		% catch
		% voFailed = [voFailed, oROI];
		% end
	end
	
	mrVistaClose;
	oView1 = [];
end

%% Logging
Save('Failed', voFailed); linux date; diary off

end %function

%% Note: type "doc hungarian" for variable prefix explanation.
