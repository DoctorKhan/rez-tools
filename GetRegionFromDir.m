function sRegion = GetRegionFromDir

% GetRegionFromDir;
%
%
%
% Khan 02/04/2012
 
%% Default params
Default sRegion

%% Initialize


%% Main
cpPathParts = regexp(pwd, '/', 'split'); 
iAnatPart = CellMatch(cpPathParts, 'Anatomy');

if iAnatPart && length(cpPathParts) - 1 > iAnatPart
	sRegion = cpPathParts{iAnatPart+2};
else
	sRegion = false;
end

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
