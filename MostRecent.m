function sFilename = MostRecent(sType, sMatch)

% sFilename = MostRecent;
%
% Returns most recent file in directory
%
% Khan 02/08/2010

if notDefined('sType'), sType = 'file'; end
if notDefined('sMatch'), sMatch = '*'; end

switch sType
    case 'session'
        curDir = pwd;
        cd(fullfile(ExportPath, 'mri', 'Raw'));
        oDir = dir;
        oDir = oDir([oDir.isdir;]);
        oDir = oDir(3:end);
        csFilenames = {oDir.name};
        csFilenames = sort(csFilenames);
        sFilename = csFilenames{end};
        cd(curDir);
    otherwise
        sFilename = ls('-1t', sMatch);
        sCr = sprintf('%c\n', ''); % Carriage return character
        sFilename(regexpi(sFilename, sCr):end) = [];
end
end
