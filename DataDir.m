function pDir = DataDir(oView, varargin)

% DataDir;
%
%
%
% Khan 07/20/2011

%% Default params


%% Initialize
Default oView=getSelectedView;

%% Main
pDir = fullfile(dataDir(oView), varargin{:});

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
