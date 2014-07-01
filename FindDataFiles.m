function [sDataDir, bSuccess] = FindDataFiles(sDir, fhFileCount)
 
%
% sDataDir = FindDataFiles(sDir, fhFileCount);
%
% Calls fhFileCount (e.g. @CountPfiles) on variations of sDir until one is
% found that returns a positive value (i.e. contains P-files).
%
% Khan 01/16/09
% Khan 06/09/09 - Updated to files.irc path structure
% Khan 02/18/10 - replaced '/export' with ExportPath for cross-platform and
% cross-computer compatibility

%% Initialize
sDataDir = [];

%% Default params

if ~exist('sDir', 'var')
    sDir = pwd;
end

if ~exist('fhFileCount', 'var')
    fhFileCount = @CountPfiles;
end

%% Directories to try
sBaseMRI = ExportPath('mri');
csPrefix = {'', fullfile(sBaseMRI, 'Raw')};
csPrefix{3} = fullfile(sBaseMRI, 'SSFP');
csPrefix{4} =  fullfile(sBaseMRI, 'SSFP', 'LaminarHemo');
csPrefix{5} = sDir;
csSuffix = {'Raw', 'Pfiles', fullfile('Raw','Pfiles'), '', 'impulseInfo', ...
    'JitterData', fullfile('Raw','impulseInfo')};
csGuess = {''};
for iPre = 1:length(csPrefix)
    for iSuf = 1:length(csSuffix)
        csGuess = horzcat(csGuess, fullfile(csPrefix{iPre}, sDir, csSuffix{iSuf}));
    end
end
csGuess = horzcat(csGuess, '.');


%% Try directories
for i = 1:length(csGuess)
    sGuess = csGuess{i};
    if (exist(sGuess, 'dir'))
        if (fhFileCount(sGuess) > 0)
             sDataDir = GetFullPathname(sGuess);       
            bSuccess = true;
            return;
        end
    end
end

% if a p-file was found, then you should not get to this statement.
%Alert(['No directory found with ', func2str(fhFileCount), ' > 0.']);
sDataDir = '.';
bSuccess = false;

end
