function  [coStruct, csFields] = Struct2Cell(oStruct)

% [coStruct, csFields] = Struct2Cell(oStruct);
%
%
%
% Khan 08/15/2011

%% Main
coStruct = squeeze(builtin('struct2cell', oStruct));
csFields = fieldnames(oStruct);
	
end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
