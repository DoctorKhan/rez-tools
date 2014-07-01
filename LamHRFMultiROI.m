function [moResults, tsSliceBlock] = LamHRFMultiROI(oTimedVolView, oSubject, voROIs, vCNR, voBins, viScans, nBoots, sOption, tsSliceBlock)

% [moResults, tsSliceBlock] = LamHRFMultiROI(oTimedVolView, oSubject, voROIs, vCNR, voBins, viScans, nBoots, sOption, tsSliceBlock);
%
%
%
% Khan 07/24/2011s

%% Default params
Default viScans sOption

%% Initialize
Destruct(oSubject); % yields sSession, sSubject
cds(sSession);
voBins = NumStruct(voBins);

%% Main

% oTimedVolView = selectDataType(oTimedVolView, 'Timed');

% Load Spatial Gradient for Inhomogeneity Correction
oTimedVolView = loadSpatialGradient(oTimedVolView);

% Load slice block with jitter correction
if notDefined('tsSliceBlock')
	tsSliceBlock = LoadSliceBlock(oTimedVolView, sOption, viScans);
end

% Load normalized distance map
[oTimedVolView, maps] = NormalizedDepthMap(oTimedVolView, Struct(sSubject, sRegion), sOption);
vNormDepthMap = maps.vNormMap;
nCNRs = length(vCNR);

linux date >> lam.log
voCNRs = mat2struct(vCNR, 'num')';

ii = 0;
for oBaseROI = voROIs
	for oCNR = voCNRs  % iterate over CNRs
		ii = ii + 1;
% 		try
			moResults{ii} = LamHRF(oTimedVolView, oBaseROI, oCNR.value, voBins, tsSliceBlock, vNormDepthMap, nBoots);
% 		catch
% 			sFullName = Str(oBaseROI.name, 'u', oCNR.value, '');
% 			linux('echo', oBaseROI.iBaseROI, sFullName, '>> lam.log');
% 		end
	end
end

end % Function
%% Note: type "doc hungarian" for variable prefix explanation.
