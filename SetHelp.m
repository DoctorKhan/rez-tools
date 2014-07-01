function SetHelp(sFilename, sHelpText, bVerbose)

% SetHelp(sFilename, sHelpText, bVerbose);
%
% example usage: SetHelp
% Adds help text (such as this) to top of *.m file--or updates function
% usage line, if it already exists.
%
% Khan 01/16/2009
% Khan 02/21/2010 - added force dateline capability
% Khan 02/22/2010 - added automatic hungarian notation at tend of file

%% Default
bForce = false;

if defined('sFilename') && strcmp(sFilename, 'force')
    sFilename = ''; bForce = true;
end

if defined('sHelpText') && strcmp(sHelpText, 'force')
    bForce = true;
end


Default sFilename = ActiveDocument;

%% Constants
sCr = sprintf('%c\n', ''); % Carriage return character

%% Initialize
sPathname = GetFullPathname(sFilename, 'trywhich'); % Full pathname of m-file
SaveDocument(sPathname);
sUsername = Username; % Get the user's name
sDateLine = ['% ', sUsername, ' ', datestr(date, 23)];

% [d, sBasename] = fileparts(sFilename); % Get the base name of m-file

% [p, n] = fileparts(sPathname);
% sPathname = [fullfile(p, n), '.m'];
if ~exist(sPathname, 'file')
    warning([sFilename, ' does not exist.']);
    return;
end

% Set initial help text
if ~defined('sHelpText')
    sHelpText = ['% ', sCr]; % Default help text
else
    sHelpText = ['% ', sHelpText, sCr];
end

% Read m-file int cell structure
csFile = ReadTextFile(sPathname);

bIsFunction = ~isempty(regexpi(csFile{1}, 'function'));

if bIsFunction
    % Add break between function name and rest of file, if necessary
    if ~isempty(strtrim(csFile{2}))
        csFile = {csFile{1}, sCr, csFile{2:end}};
    end
    
    % This will be the function usage (first) line of help text
    sFuncLine = ['% ', strtrim(csFile{1}(10:end)), ';', sCr];
    
end

%% Main
if strmatch(help(sPathname), 'No help')
    % If there are no help lines set, then create them
    sHelp = ['% ', strtrim(csFile{1}(10:end)), ';', sCr, ...
        '% ', sCr, sHelpText, '% ', sCr, ...
        sDateLine, sCr];
    csFile = {csFile{1:2}, sHelp, sCr, csFile{3:end}};
else
    % Look for function usage line of help text
    if isequal(strtrim(csFile{3}), '%')
        iFuncLine = 4; % We want to skip first blank help line
    else
        iFuncLine = 3;
    end
    
    % Update function line
    if  bIsFunction && (length(csFile) >= iFuncLine)
        sLine = strtrim(csFile{iFuncLine});
        if ~isempty(sLine) && sLine(1) == '%' && sLine(end) == ';'
            csFile{iFuncLine} = sFuncLine;
        else
            csFile = {csFile{1:iFuncLine-1}, sFuncLine, '%', csFile{iFuncLine:end}};
        end
    end
    
    % Add user date line
    sCurrentHelp = help(sFilename);
    % If there is no dateline with your name or force flag set, then add it
    if isempty(strfind(sCurrentHelp, sUsername)) || bForce
        % Look for end of help section
        for iDateLine = iFuncLine:length(csFile)
            % Grab current line of file
            sLine = strtrim(csFile{iDateLine});
            if ~isempty(strfind(sLine, '%')) && isempty(strfind(sLine, '%%'))
                % Skip existing help lines
                continue;
            else
                % Add line before datelines, if necessary
                if isempty(regexpi(csFile{iDateLine-1}, '/'))
                    csFile = {csFile{1:iDateLine-1}, '%', sDateLine, csFile{iDateLine:end}};
                    iDateLine = iDateLine+1;
                else
                    csFile = {csFile{1:iDateLine-1}, sDateLine, csFile{iDateLine:end}};
                end
                
                % Add blank line after date line, if necessary
                sLine = strtrim(csFile{iDateLine+1});
                if length(csFile) >= iDateLine && ~isempty(sLine)
                    csFile = {csFile{1:iDateLine}, '', csFile{iDateLine+1:end}};
                end
                
                % Add additional line in middle to enter help text manually
                if isequal(csFile{iDateLine-1}, '%') && isequal(csFile{iDateLine-2}, '%') ...
                        && isequal(csFile{iDateLine-3}, sFuncLine)
                    csFile = {csFile{1:iDateLine-1}, '%', csFile{iDateLine:end}};
                end
                
                break;
            end
        end
    end
end

% Add hungarian notation explanation, if necessary
bUpdateHungarian = true;
for iLine = 1:length(csFile)
    sLine = strtrim(csFile{iLine});
    sHungarian = '%% Note: type "doc hungarian" for variable prefix explanation.';
    if length(sLine) >= length(sHungarian)
        sLine = sLine(1:length(sHungarian));
    end
    if isequal(sLine, sHungarian), bUpdateHungarian = false; break;end
end

if bUpdateHungarian
    csFile = {csFile{:}, '', sHungarian};
end

%% Output
try
    Backup(sPathname);
end
WriteTextFile(sPathname, csFile);

if defined('bVerbose')
    help sFilename
end

% if ~isempty(strfind(version, 'R2007'))
    % Version 2007 and below require reopening to see updated file.
    CloseDocument(sPathname);
    edit(sPathname);
% end

% Bring focus or open
% edit(sPathname)
% com.mathworks.mlservices.MLEditorServices.reloadDocument(sPathname);

end

%% Note: type "doc hungarian" for variable prefix explanation.
