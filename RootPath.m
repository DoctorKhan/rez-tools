function sPath = RootPath(varargin)

% sPath = RootPath(varargin);
%
%
%
% Khan 07/06/2011

%% Default params


%% Initialize


%% Main
if ispc
    sMatRoot = matlabroot;
    sRoot = sMatRoot(1:2);
else
    sRoot = '/';
end

sPath = fullfile(sRoot, Str(varargin{:},{filesep}));

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
