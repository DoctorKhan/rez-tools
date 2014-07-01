function varargout = Help(sQuery)

% Help(sQuery);
%
% Mediates case sensitive search for Help.
%
% Khan 12/09/2011
 
%% Arg handling
if notDefined('sQuery')
	doc
	return
end

%% Initialize
% pCur = pwd;
% pHelpLoc = fullfile(matlabroot, 'toolbox', 'matlab', 'Helptools');

%% Main
% cd(pHelpLoc)
varargout{1:nargout} = help(which(sQuery));

%% Cleanup
% cd(pCur);

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
