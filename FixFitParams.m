function oResults = FixFitParams(voFiles, voHemo)

% oResults = FixFitParams(voFiles, voHemo);
%
%
%
% Khan 11/30/2011

%% Default params
if notDefined('voFiles'), voFiles = FindHemoFiles; end

%% Initialize
HemoInit
pCur = pwd;

%% Main
for oHemo = NumStruct(voHemo, 'backup')
	cds(oHemo)
	for oFile = NumStruct(voFiles, 'backup');
		oResults = Load(oFile);
		if ~defined(oResults, 'voFit')
			oResults.voFit = LaminarFits(oResults.omBootParams, oResults.oROI.voBins);
			Str(oFile.iBak, oHemo.iBak)
			Save(oFile.name, oResults);
		end
		TextWaitbar(oFile, oHemo);
	end
end

cd(pCur);

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
