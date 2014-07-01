function sSubject = GetSubjectFromDir(pDir)

% sSubject = GetSubjectFromDir(pDir);
%
%
%
% Khan 02/04/2012
 
%% Default params
Default sSubject | sSubjectHR | pDir = pwd;

%% Initialize

%% Main
sSubject = regexprep(regexprep(pDir, '.*/Anatomy/', ''), 'HR.*', ''); 
% iAnatPart = CellMatch(cpPathParts, 'Anatomy');

% if iAnatPart && length(cpPathParts) - 1 > iAnatPart
% 	sSubject = cpPathParts{iAnatPart+1}(1:end-2);
% end

if ~isSubject(sSubject)
	sSubject = false;
end

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
