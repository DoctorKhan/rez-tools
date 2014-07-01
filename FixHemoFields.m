function FixHemoFields(voHemo1, voFilesIn)

% FixHemoFields;
%
%
%
% Khan 12/01/2011

%% Default params


%% Initialize
HemoInit

%% Main
for oHemo = voHemo1
	cds oHemo
	if defined('voFilesIn')
		voFiles = voFilesIn;
	else
		voFiles = Ls('*.mat');
	end
	for oFile = voFiles
		oResults = Load(oFile);
			if ~isfield(oResults, 'voHrfs') || ~isfield(oResults, 'oMeanHRFs')
				if CellMatch(fieldnames(oResults), 'HRFs')
					Str(oHemo, ':', oFile);
					oResults = RenameFields(oResults, {'oHRFs', 'voHrfs'}, {'oHrfs', 'voHrfs'}, {'voMeanHRFs', 'oMeanHRFs'});
					Save(oFile, oResults);
				end
			end		
		end
	end
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
