function b = isSession(sSession)

% isSession;
%
%
%
% Khan 02/02/2012
 
%% Default params


%% Initialize


%% Main
b = ischar(sSession) && ~isempty(regexp(sSession, '[0-9]{6}[^0-9]{2}', 'once'));

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
