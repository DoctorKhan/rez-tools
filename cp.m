function cp(sSrcFile, sDestFile)

% cp(sSrcFile, sDestFile);
%
% Calls linux cp command. Works better than copyfile sometimes.
%
% Khan 07/01/2011

%% Arg handling
if exist([sSrcFile, '.m'], 'file'),
	sSrcFile  = [sSrcFile,  '.m'];
	sDestFile = [sDestFile, '.m'];
end

%% Main
linux('cp -f', quote(sSrcFile), quote(sDestFile));

end % function

%% Note: type "doc hungarian" for variable prefix explanation.
