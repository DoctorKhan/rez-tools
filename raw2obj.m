function [sOut, iStatus] = raw2obj(varargin)

% [sOut, iStatus] = raw2obj(varargin);
%
%
%
% Khan 06/30/2011

%% Default params


%% Initialize


%% Main
[sOut, iStatus] = linux('raw2obj', varargin{:});

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
