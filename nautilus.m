function nautilus(sDir)

% nautilus(sDir);
%
% Start nautilus file browser.
%
% Khan 11/08/2010

%% Default params
if notDefined('sDir'), sDir = ''; end

%% Initialize


%% Main
linux(['nautilus ', sDir, '&']);

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
