function sDate = Today

% Today;
%
%
%
% Khan 07/15/2011

%% Default params


%% Initialize


%% Main
sDate = regexprep(datestr(date, 23), '/', '-');

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
