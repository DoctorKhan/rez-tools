% HemoInit;
%
% Hemodynamics initialization variables.
%
% Khan 07/11/2011

mrGlobals
%% Time
vT  = linspace(0, 27, 19);
vTi = linspace(0, 27, 2701);

mrGlobals

Default voPar = NameStruct('fwhm', 'peak', 'dip', 'under', 'hrf');
Default voMetric = NameStruct('thick', 'curve', 'whole');
Default isoValue = 0.5;

%% Time
Default vT  = linspace(0, 27, 19)
Default vTi = linspace(0, 27, 500)

%% Bins
% 1. Default voDepthBins = BinBounds(.1, .25); next
Default voDepthBins = BinBounds(.15, .25);
% 2. Use 5-95% cdf
Default voCurvBins  = BinBounds(0.14, 0.14, [-.21 .21])
% 3. Delimit range based on narrowest range of gray matter subject
Default voThickBins = BinBounds(.6,   .6,   [.6  4.8], 'lower');

% 4. [-1 -0.2 ] [ 0.2 0.8 ] [ 1.2 2 ]
Default voRegBins   = BinBounds(1,1)

Default nBoots = 1200 | nBootstraps = 1200 | nStraps = 1200
Default sRegion = "Cortex"

%% Default params

if notDefined('voHemis')
	voHemis(1).sHemi = 'Left';  voHemis(1).hemi = 'L';
	voHemis(2).sHemi = 'Right';	voHemis(2).hemi = 'R';
	voHemis = NumStruct(voHemis, 'iHemi');
end

Default iGridSize = 350   | nSurfaces = 16
Default nErodeLayers = 5  | nExtraLayers = 5
Default nSamples = 100000 | vMaxVal = [6 6 6 0.5]
Default vCNRs  = [25 50 75 100]

%% Subjects
if notDefined('voHemo3')
	csSessions = {'031010cg', '030310rk', '031810dr', '050310dt', '100611cb', '031710sk', '072611cg'};
	csSubjects = {'Greene', 'Khan', 'Ress', 'Tucker', 'Combined', 'Katyal', 'Greene'};
	
	voHemo3 = Cell2HorzStruct(vertcat(csSubjects, csSessions), {'name', 'sSession'});
	[voHemo3.sRegion] = deal('Cortex');
	voHemo3 = CopyField(voHemo3, 'name', 'sSubject');
	voHemo3(end).name = 'Sim';
end

Default voHemo2 = NumStruct(voHemo3(1:end-1))
Default voHemo1 = NumStruct(voHemo2(1:end-1))
Default voHemo  = NumStruct(voHemo1(1:end-1))
Default nSubjects = length(voHemo)

%%
for oHemo0 = voHemo, Default(['o', oHemo0.name], oHemo0); end

for oHemo3 = voHemo3(end-3:end)
	Default(['o', oHemo3.name], oHemo3)
end

Default voPlot8Bins = BinBounds([-.25 .167 0.5 0.833 1.25], .25);
%%
% if notDefined('voHemo')
% 	for oHemo0 = voHemo
% 		ii = oHemo.iNum;
% 		voHemo(ii).pWhiteMesh = AnatPath(voHemo(ii).sSubject, sRegion, '3DMeshes', 'BothFullRefined.mat');
% 		if ~exist(voHemo(ii).pWhiteMesh, 'file'), error('Invalid mesh pathname.'); end
% 		voHemo(ii).sRegion = sRegion;
% 	end
%
% 	csSessions = {voHemo.sSession,};
% 	csSubjects = {voHemo.sSubject,};
% end
%% Main
% csBaseROIs = cell(1, 12);
% csBaseROIs = {};
% for iArea = 1:3
% 	for DV = 'DV'
% 		csBaseROIs{end+1} = Str('V', iArea, DV, 'p', '');
% 	end
% 	csBaseROIs{end+1} = Str('V', iArea, 'dv', '');
% end
% csBaseROIs = {csBaseROIs{:}, 'VVp', 'VDp', 'V123p', 'V23p'};

%%
% csBaseROIs = {'V1Lp', 'V2DLp', 'V2VLp' 'V3ALp', 'V3DLp', 'V3VLp', 'hV4Lp', 'V14Lp' ...
%               'V1Rp', 'V2DRp', 'V2VRp' 'V3ARp', 'V3DRp', 'V3VRp', 'hV4Rp', 'V14Rp'};
% csBaseROIs = {V1Dp, V1Vp, V1p, V2Dp, V2Vp, V2p, V3Dp, V3Vp, V3p, VVp, VDp, V123p, V23p}
csMainROIs = combstr('V', {'1', '2', '3'}, {'', 'D', 'V'}, 'p');
csCombROIs = combstr('V', {'V', 'D', '23', '123'}, 'p');
csBaseROIs = horzcat(csMainROIs, csCombROIs);

%% Make base ROIs
if notDefined('voBaseROIs')
	voBaseROIs = Cell2HorzStruct(csBaseROIs);
	[voBaseROIs.comment] = deal([]);
	
	for oBaseROI = voBaseROIs
		comment = regexprep(oBaseROI.name, 'Lp', ' Left hemisphere');
		comment = regexprep(comment, 'Rp', ' Right hemisphere');
		comment = regexprep(comment, 'p', ' Both hemispheres');
		voBaseROIs(oBaseROI.iNum).comment = comment;
		Default(oBaseROI.name, 'oBaseROI');
	end
end

%% CNRs
for iNum = 1:length(vCNRs)
	value = vCNRs(iNum);
	name = num2str(value);
	comment = Str('Upper', value, 'percent of CNR rated voxels');
	voCNRSet(iNum) = Struct(name, value, comment, iNum);
end

%% Threshed ROIs
voThreshROIs = [];
for oBaseROI = voBaseROIs
	for cnr = vCNRs
		sCnr = num2str(cnr);
		parentname = oBaseROI.name;
		name = [parentname, 'u', sCnr];
		comment = [regexprep(regexprep(parentname, 'Lp', ' Left hemisphere'), 'Rp', ' Right hemisphere'), ...
			' - Upper ', sCnr, ' percent of CNR rated voxels'];
		filename =  ['BootHRFAnalysis-', name ];
		oThreshROI = Struct(name, parentname, filename, comment, cnr);
		voThreshROIs = [voThreshROIs, oThreshROI];
	end
end

voThreshROIs = NumStruct(voThreshROIs);

for oThreshROI = voThreshROIs
	eval([oThreshROI.name '= oThreshROI;']);
end

Default voHemoAll = voHemo;

% issued: linux echo V1{L,R}p V2{D,V}{L,R}p V3{A,D,V}{L,R}p hV4{L,R}p

%% Note: type "doc hungarian" for variable prefix explanation.
