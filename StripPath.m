function sFilename = StripPath(pPathname)

% StripPath;
%
%
%
% Khan 06/26/2011

%% Default params


%% Initialize


%% Main
[~, sBase, sExt] = fileparts(pPathname);

sFilename = [sBase, sExt];

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
