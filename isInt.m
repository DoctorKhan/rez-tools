function b = isInt(v)

% b = isInt(v);
% 
% check if it is an integer
% 
% Rez 02/17/2010
% Khan 12/01/2011 - accepts numeric strings.

%% Arg handling
if isNumStr(v)
	v = str2double(v);
elseif iscell(v)
    b = all(CellFun(@isInt, v)); return
end

%% Main
if isnumeric(v)
	b = logical(repmat(isnumeric(v), size(v))) & logical((v == round(v)));	
else
	b = false; 
end


end
 
%% Note: type "doc hungarian" for variable prefix explanation.
