% HemoInit;
%
% Hemodynamics initialization variables.
%
% Khan 07/11/2011

mrGlobals

if notDefined('voPar')
    voPar = NameStruct('fwhm', 'peak', 'dip', 'under', 'hrf');
end
if notDefined('voMetric')
    voMetric = NameStruct('thick', 'curve', 'whole');
end

Default isoValue = 0.5;


if notDefined('voHemis')
	voHemis(1).sHemi = 'Left';  voHemis(1).hemi = 'L';
	voHemis(2).sHemi = 'Right';	voHemis(2).hemi = 'R';
	voHemis = NumStruct(voHemis, 'iHemi');
end

Default iGridSize = 350   | nSurfaces = 16
Default nErodeLayers = 5  | nExtraLayers = 5
Default nSamples = 100000 | vMaxVal = [6 6 6 0.5]
Default vCNRs  = [25 50 75 100]

%% Time
Default vT  = linspace(0, 27, 19)
Default vTi = linspace(0, 27, 500)

%% Bins
if notDefined('voCurvBins') || notDefined('voThickBins')
	try
		bExistMaps = exist(SessionDir('CombinedMaps.mat'), 'file');
		bIsSessionDir = exist(SessionDir('mrSESSION.mat'), 'file');
		
		if bIsSessionDir && ~bExistMaps
			CollectHemoMaps;
		end
		
		if bExistMaps
			load('CombinedMaps');
			voCurvBins  = BinBounds(.1, .1, oBounds.vCurve, 'Curvature');
			voThickBins = BinBounds(.6, .6, oBounds.vThick, 'Thickness', 'lower');
		end
    catch
        voCurvBins  = BinBounds(.1, .1, [-.2 .0], 'Curvature');
			voThickBins = BinBounds(.6, .6, [1.6 4], 'Thickness', 'lower');
	end
end

voPlot8Bins = BinBounds([-.5 .125 0.5 0.875 1.5], .25);
voDepthBins = BinBounds(linspace(-1,2,31), .25, [], 'Depth');
% Default voDepthBins = BinBounds(.15, .25);

% Default voCurvBins  = BinBounds(0.14, 0.14, [-.21 .21])
% 3. Delimit range based on narrowest range of gray matter subject

% 4. [-1 -0.2 ] [ 0.2 0.8 ] [ 1.2 2 ]
voRegBins   = BinBounds(1,1);

Default nBoots = 1200 | nBootstraps = 1200 | nStraps = 1200
Default sRegion = "Cortex"
Default vNormBounds = [ -1 2 ];
voTemp20394 = BinBounds([-.25 .167 0.5 0.833 1.25], 0.25);
Default voPlot8Bins = voTemp20394; clear('voTemp20394');

%% Default params
Default percentCNR = 50

Default voHemis = Str2Struct({'Left', 'Right'}, 'sHemi')

Default iGridSize = 350   | nSurfaces = 16
Default nErodeLayers = 5  | nExtraLayers = 5
Default nSamples = 100000 | maxDepth = 6 | maxCurve = 0.5;
Default vCNRs = [25 50 75 100]

%% Subjects
if notDefined('voHemoAll')
	csSessions = {'031010cg', '030310rk', '031810dr', '050310dt', '100611cb', '031710sk', '072611cg'};
	csSubjects = {'Greene',   'Khan',     'Ress',     'Tucker',   'Combined', 'Katyal',   'Greene'};
	cpDir = MixedMatch({ExportPath('mri', 'LaminarHemo')}, csSessions);
	csSessionDirs = CellFun(@fullfile, cpDir, csSessions);
	
	voHemoAll = Cell2HorzStruct(vertcat(csSubjects, csSessions, csSessionDirs), {'name', 'sSession', 'pSession'});
	[voHemoAll.sRegion] = deal('Cortex');
	[voHemoAll.sHemi] = deal('Both');
	voHemoAll = CopyField(voHemoAll, 'name', 'sSubject');
	voHemoAll(end).name = 'Sim';
end

 % Combined, Katyal, Sim
NameStruct(voHemoAll, 'prefix=o');

if notDefined('voHemo')
    voHemo = NumStruct([oGreene oKhan oRess oTucker]);
end

Default nSubjects = length(voHemo)
% if notDefined('voHemo1 voHemo1 = NumStruct([voHemo oCombined]);
% Default voHemo2 = NumStruct([voHemo1 oSim])
Default oSphere = struct('sSubject', 'Sphere', 'sRegion', 'Cortex', 'sHemi', 'Both', 'sSession', '012512sp', 'iNum', 1, 'nTot', 1);
%%

%%
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
        voBaseROIs(oBaseROI.iNum).name = ['Laminar' oBaseROI.name 'u50'];
		Default(oBaseROI.name, 'oBaseROI');
	end
end

NameStruct(voBaseROIs, 'prefix=o');

NameStruct(voBaseROIs);
%%
voTissue = NameStruct('White', 'Pia');
voHemisBoth = NumStruct([voHemis voHemis(end)]);
voHemisBoth(end).sHemi = 'Both';
voHemisBoth(end).hemi = 'B';
voHemisBoth(end).iNum = 3;

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

% issued: linux echo V1{L,R}p V2{D,V}{L,R}p V3{A,D,V}{L,R}p hV4{L,R}p

%% Note: type "doc hungarian" for variable prefix explanation.
