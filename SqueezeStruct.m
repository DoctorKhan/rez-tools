function oStruct = SqueezeStruct(oStruct)

% SqueezeStruct;
%
% Strip top level structures with only one field.
%
% Khan 07/29/2011

%% Default params


%% Initialize


%% Main
while isstruct(oStruct) && length(fieldnames(oStruct)) == 1
	csField = fieldnames(oStruct);
	oStruct = oStruct.(csField{1});
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
