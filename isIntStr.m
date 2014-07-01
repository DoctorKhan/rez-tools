function bIsIntStr = isIntStr(sIn)

% bIsIntStr = isIntStr(sIn);
%
%
%
% Khan 11/19/2011

%% Default params


%% Initialize


%% Main
try
	sTrim1 = strtrim(sIn);
	val = str2double(sTrim1);
	sTrim2 = num2str(val); 
	bIsIntStr = strcmp(sTrim1, sTrim2) && isInt(val);
catch
	bIsIntStr = false;
end



end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
