function [iFree iUsed] = Ram(sFlags)

% [iFree iUsed] = Ram(sFlags);
%
%
%
% Khan 08/17/2011

%% Default params
Default sFlags = "-b"

%% Initialize


%% Main
iUsed = linux('free', sFlags, '| grep ^- | awk ''{print $3}''');
iFree = linux('free', sFlags, '| grep ^- | awk ''{print $4}''');

end % Function

%% Note: type "doc hungarian" for variable prefix explanation.
