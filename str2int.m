function iOut = str2int(xIn, viInd)

% iOut = str2int(xIn);
%
%
%
% Khan 11/19/2011

%% Default params
Default xIn = NaN

%% Main
if ischar(xIn)
	iOut = round(str2double(xIn));
elseif isnumeric(xIn)
	iOut = round(xIn);
elseif iscell(xIn)
	viInt = cellfun(@str2int, xIn);
	viInt(isnan(viInt)) = [];
	Default viInd = 1:length(viInt);
	viInd(viInd>length(viInt)) = [];
	iOut = viInt(viInd);
else
	iOut = NaN;
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
