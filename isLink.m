function bLink = isLink(pFile)

% isLink;
%
%
%
% Khan 07/05/2011

%% Default params


%% Initialize


%% Main
if strcmp(linux('tester', 'test -L', pFile), 'true')
	bLink = true;
else
	bLink = false;
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
