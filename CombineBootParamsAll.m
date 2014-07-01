function [voFailed, voResult] = CombineBootParamsAll(voROIFiles, voHemo, oCombined)

% varargout = CombineBootParamsAll(voROIFiles, voHemo, oCombined);
%
%
%
% Khan 10/04/2011

%% Default params
Default voROIFiles = FindHemoFiles
Default nOrder = 1
HemoInit

%% Arg handling
if ~isstruct(voROIFiles)
	% Collect intersection of roi files amongst subjects
	voROIFiles = FindHemoFiles(voROIFiles);
end

%% Preallocation
oROIFile1 = voROIFiles(1);
nFiles = oROIFile1.nTot;

oResult1 = CombineBootHRFParams(oROIFile1, voHemo, oCombined);
voResTmp = repmat(oResult1, [1 nFiles]);

%% Initialize
% Preallocation
voFailTmp = repmat(EmptyStruct(oROIFile1), [1 nFiles]);

%% Main Loop
% Iterate over ROI files yielding combined subject results
for oROIFile = voROIFiles(2:end)
	iFile = oROIFile.iNum;
	try
		voResTmp(iFile) = CombineBootHRFParams(oROIFile, voHemo, oCombined);
	catch
		voFailTmp(iFile) = oROIFile;
		voResTmp(iFile) = EmptyStruct(voResTmp(iFile));
	end
	TextWaitbar(oROIFile);
end

%% Output
if nargout > 0
	voFailed = squeeze(voFailTmp);
end
if nargout > 1
	voResult = squeeze(voResTmp);
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
