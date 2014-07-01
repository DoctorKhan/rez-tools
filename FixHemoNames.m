function FixHemoNames

% FixHemoNames;
%
%
%
% Khan 11/08/2011

%% Default params


%% Initialize
HemoInit

%% Main

for o = Ls('BootHRFAn*.mat'), mv(o.name, regexprep(o.name, 'u50', '')); end
for o = Ls('BootHRFAn*.mat'), mv(o.name, regexprep(o.name, 'Laminar', '')); end

% for oHemo = voHemo
% 	FixIt(oHemo, 'Volume/ROIs');
% 	FixIt(oHemo, 'Gray/ROIs');	
% end

end % Function

function FixIt(oHemo, pDir)
	pCur = pwd;
	cds(oHemo)
	cd(pDir)

	for oFile = Ls('*.mat')
		TextWaitbar(oFile, oHemo);
		oROI = Load(oFile);
		if isstruct(oROI) && isfield(oROI, 'coords')
			ROI = structfun(@FixStr, oROI, 'UniformOutput', false);
			sFixedName = FixStr(StructName(oFile));
			Save(sFixedName, ROI);
		end
	end

cd(pCur)
end

function sStr = FixStr(sStr)
	if ischar(sStr)
		sStr = regexprep(sStr, 'dv', 'p');
		sStr = regexprep(sStr, 'ExtraStriate', 'V23p');
		sStr = regexprep(sStr, 'V13', 'V123p');
	end
end

%% Note: type "doc hungarian" for variable prefix explanation.
