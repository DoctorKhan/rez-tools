function sDateDesired = Yesterday

% Yesterday;
%
% Returns a string with the date for yesterday.
%
% Khan 07/06/2010

%% Default params


%% Initialize


%% Main

    sYesterday = num2str(str2double(datestr(date, 'dd')) - 1);
    sDateDesired = [datestr(date, 'mm'), '-', sYesterday, '-', datestr(date, 'yyyy')];

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
