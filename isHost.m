function bOnHost = isHost(sHostname)

% bOnHost = isHost(sHostname);
%
% Returns true if you are on specified host.
%
% Example: isHost sandstone
%
% Khan 06/25/2010

%% Error checking

%% Main
if ispc
	bOnHost = false;
else
	bOnHost = logical(str2double((linux('uname -a | grep -ic ', sHostname))));
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
