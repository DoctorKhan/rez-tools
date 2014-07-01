function WriteTextFile(pOut, csText, sDelim, iRow)

% WriteTextFile(pOut, csText);
%
% Write cell structure of strings to a file.
%
% Khan 02/17/2010

%% Default params

    Default sDelim = ' ';
Default iRow = 1;
%% Initialize
sCr = sprintf('%c\n', ''); % Carriage return character

% Each element of csText is a line

%% Main
if iscell(csText)
    for iLine = 1:length(csText)
        sLine = csText{iLine};

		if isempty(sLine), sLine = ' '; end
		
		% Add return at end of line
        if isempty(regexpi(sLine, sCr))
            sLine = [sLine, sCr];
        end
        csText{iLine} = sLine;
    end
    sAllText = Str(csText{:}, {sDelim
        });
else
    sAllText = csText;
end

dlmwrite(pOut, sAllText, '', iRow-1);

end %function

%% Note: type "doc hungarian" for variable prefix explanation.
