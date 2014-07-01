function Assign(assignee, assignment)

% Assign;
%
%
%
% Khan 07/15/2011

%% Default params


%% Initialize
if ischar(assignment), assignment = quote(assignment, 'single'); end

%% Main
evalin('caller', [assignee, ' = ', assignment, ';'])

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
