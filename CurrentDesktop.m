function xDesk = CurrentDesktop(sPrefix)

% [iDesk, sDesk] = CurrentDesktop(sType);
%
%
%
% Khan 08/11/2011

%% Default params


%% Initialize


%% Main
iDesk = str2double(linux('xdotool get_desktop')) + 1;
if isnan(iDesk), xDesk = []; return; end
sDesk = num2str(iDesk);

if defined('sPrefix')
	xDesk = [sPrefix, sDesk];
else
	xDesk = iDesk;
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
