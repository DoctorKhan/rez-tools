function sDef = Dict(sWord)

%
% sDef = Dict(sWord);
%
% Retrieves the definition of a word from webster.com.
% Works on Mac and Linux. May or may not work on Windows.
%
% Khan  11/05/09
%

%% Initialization
sCr = sprintf('%c\n', ''); % Carriage return character

setupDict; % set up parameters
% This is the Mac OS location for lynx
sLynxCommand = '/Applications/Lynxlet.app/Contents/Resources/lynx/bin/lynx';

%% Default params
% If not input provided, supply a random word.
if ~exist('sWord', 'var'), sWord = GetWord;
end

% If it is not installed on a Mac, just try the standard unix command
if ~exist(sLynxCommand, 'file'), sLynxCommand = 'lynx'; end

%% Run command
sUnixCommand = [sLynxCommand ' -dump http://www.merriam-webster.com/dictionary/', sWord ];
[iStatus, sDef] = system(sUnixCommand);

%% Error checking
if iStatus ~= 0, error('Please install lynx. (Or Lynxlet for Mac).'); end
if isempty(regexpi(sDef, 'Main Entry'))
    sDef = linux(['lynx -dump "http://www.google.com/search?ie=UTF-8&oe=UTF-8&sourceid=navclient&gfns=1&q=' sWord '" | grep "Did you mean to"']);
    sDef = ['Main Entry not found.', sDef];
    sDef(regexpi(sDef, ':')) = [];
    sDef(end) = '?';
end

%% Parsing
% Replace "Main Entry" with the word and remover everything before it
[iBeg iEnd ] = regexpi(sDef, 'Main Entry:');
sDef = [sWord, sDef(iEnd:end)]; 

% Remove Bing Ad and everything after
sDef(regexpi(sDef, 'Bing Learn more about'):end) = [];

% Remove pronunciation line
sDef(regexpi(sDef, 'Pronunciation'):regexpi(sDef, 'Function')-1) = []; 

% Replace weird characters
sDef(regexpi(sDef, '�')) = '-'; % Replace dot with hyphen.
sDef(regexpi(sDef, '�')) = 'a';
 
% Remove [123] footnotes
while regexpi(sDef, '[')
    iBeg = regexpi(sDef, '[');
    iEnd = regexpi(sDef, ']');
    sDef(iBeg:iEnd) = []; 
end

% Remove "(not implemented)_____"
sDef = RemoveString(sDef, '\(not implemented\)');
sDef = RemoveString(sDef, '\_');

% Remove "^1"
sDef = RemoveString(sDef, '\^[1-9]');

% Removing trailing spaces.
sDef = strtrim(sDef);

% Limit number lines
viCr = regexpi(sDef, sCr);
nLines = length(viCr)+1;

if nLines > nLinesMax
    sDef(viCr(nLinesMax):end) = [];
end

end % function

% % Remove leading white space
% for iCr = viCr
%     while(isspace(sDef(viCr+1))), sDef(viCr+1:viCr+3) = []; end
% end

% Output
% sDef = ['Definition: ', sWord, sCr, sCr, sDef];
% Parse out extraneous text
% sUnixCommand = [sUnixCommand ' | sed "s/\^1//g"'];
% sUnixCommand = [sUnixCommand ' | sed "s/Main Entry:/Main Entry:', sWord, ' : /g"'];
% sSingleQuote = char(39);
% sUnixCommand = [sUnixCommand ' | sed ', sSingleQuote, 's/Bing Learn more about.*$//g', sSingleQuote];

% sDef(regexpi(sDef, 'Main'):regexpi(sDef,
% 'Function')-1) = [];
% sDef(regexpi(sDef, 'IFRAME'):end) = []; % Remove
% everything after and including "IFRAME"

% sDef(1:(regexpi(sDef, 'Main')-1)) = []; % Remove everything before "Main"