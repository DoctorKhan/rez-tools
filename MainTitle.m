function MainTitle(varargin)

% MainTitle(varargin);
%
%
%
% Khan 09/28/2011

%% Default params


%% Initialize


%% Main
jDesktop = com.mathworks.mde.desk.MLDesktop.getInstance;
jDesktop.getMainFrame.setTitle(Str(varargin{:}));

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
