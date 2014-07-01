function iOut = Str2Num(xIn, viInd)

% iOut = Str2Num(xIn);
%
%
%
% Khan 11/19/2011

%% Default params
Default xIn = NaN

%% Main
if ischar(xIn)
	iOut = str2double(xIn);
	if isnan(iOut), iOut = xIn; end
elseif isnumeric(xIn)
	iOut = xIn;
elseif iscell(xIn)
	v = CellFun(@Str2Num, xIn);
	v(isnan(v)) = [];
	Default viInd = 1:length(v);
	viInd(viInd>length(v)) = [];
	iOut = v(viInd);
else
	iOut = NaN;
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
