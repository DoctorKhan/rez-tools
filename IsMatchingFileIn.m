function bool = IsMatchingFileIn(sDir, sMatch)

% 
% bool = IsMatchingFileIn(sDir, sMatch);
%
% Tests whether files matching a regular expression, 'sMatch,' exists in directory 'sDir'
%
% Khan 12/08

if ~exist(sDir, 'dir')
    sDir = pwd;
end

sFiles = dir(fullfile(sDir, sMatch));
bool = length(sFiles);

end