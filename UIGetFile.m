function [pathname, filename, path, filterindex] = UIGetFile(filterspec)

% [pathname, filename, path, filterindex] = UIGetFile(filterspec);
%
% 
%
% Khan 11/15/2011

%% Default params


%% Initialize
Default filterspec

%% Main
[filename, path, filterindex] = uigetfile(filterspec);
pathname = fullfile(path, filename);

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
