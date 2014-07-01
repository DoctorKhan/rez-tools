function DatabaseDisplay(ccIn, viCols)

% DatabaseDisplay;
%
% Each line is a cell element of ccIn, and each word is a cell element of
% the line.
%
% Khan 02/22/2010

%% Initialize
if notDefined('ccIn'), return; end
if ~iscell(ccIn{1}), ccIn = {ccIn}; end

%% Main
for iString = 1:length(ccIn{1})
	
	if isinf(viCols(iString));
		viCols(iString) = 0;
		
		for iCell = 1:length(ccIn)
			csLine = ccIn{iCell};
			try
				sString = csLine{iString};
			catch
				sString = '';
			end
			iLimit = length(sString);
			
			viCols(iString) = max(iLimit, viCols(iString));
		end
		
	end
	
end

for iCell = 1:length(ccIn)
	csLine = ccIn{iCell};
	sLine = [];
	for iString = 1:length(csLine)
		% 		if isnumeric(
		sString = csLine{iString};
		iLimit = viCols(iString);
		if length(sString) > iLimit
			sString = sString(1:iLimit);
		end
		if isfinite(iLimit)
			sLine = [sLine, sprintf(['%-', num2str(iLimit), 's'], sString), '  '];
		else
			sLine = [sLine, sString];
		end
	end
	sLine = regexprep(sLine, '/Readme.txt', '');
	sLine = strtrim(regexprep(sLine, '/export/data/mri/', ''));
	v = get(0, 'CommandWindowSize') - 3;
	
	if length(sLine) > v(1), sLine = sLine(1:v(1));	end
	disp(sLine);
end

end %function


%% Note: type "doc hungarian" for variable prefix explanation.
