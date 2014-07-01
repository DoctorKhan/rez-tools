function b = isEmail(s)

% isEmail;
%
%
%
% Khan 01/18/2012
 
%% Default params


%% Initialize
Default s

%% Main
iPos = regexp(UserEmail(s, 'quiet'), '@', 'once');
b = ~isempty(iPos) && iPos > 1;

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
