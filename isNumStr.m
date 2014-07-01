function bIsNumStr = isNumStr(sIn)

% bIsNumStr = isNumStr(sIn);
%
% is it a numeric string.
%
% Khan 08/17/2011

%% Default params


%% Initialize


%% Main
try
	sTrim1 = strtrim(sIn);
	sTrim2 = num2str(str2double(sTrim1));
	bIsNumStr = strcmp(sTrim1, sTrim2);
catch
	bIsNumStr = false;
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
