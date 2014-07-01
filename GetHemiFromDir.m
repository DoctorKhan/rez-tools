function sHemi = GetHemiFromDir

% GetHemiFromDir;
%
%
%
% Khan 02/04/2012
 
%% Default params
Default sHemi

%% Initialize


%% Main
cpPathParts = regexp(pwd, '/', 'split'); 
iAnatPart = CellMatch(cpPathParts, 'Anatomy');

if iAnatPart && length(cpPathParts) - 2 > iAnatPart
	sHemi = cpPathParts{iAnatPart+3};
else
	sHemi = false;
end

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
