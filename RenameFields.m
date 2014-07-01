function [oStructNew, csParams] = RenameFields(oStruct, varargin)

% [oStruct, csParams] = RenameFields(oStruct, varargin);
%
% RenameFields(oStruct, {'current name', 'desired'}, {'current name', ...})
%
% Khan 08/15/2011

%% Default params
Default oStructNew | csParams

%% Initialize
if ~isstruct(oStruct), return; end

[cContents, csFields] = Struct2Cell(oStruct);
if iscellstr(varargin{1}), varargin = [varargin{:}]; end
%% Main

for iArg = 1:2:length(varargin)
	sOldName = varargin{iArg};
	sNewName = varargin{iArg+1};
	iCell = CellMatch(csFields, [ '^' sOldName '$']);
	if iCell
		csFields{iCell} = sNewName;
	end
end

for oField = Str2Struct(csFields)
	oStructNew.(oField.name) = cContents{oField.iNum};
end
	
csParams = fieldnames(oStructNew);

end % Function

%% Note: type "doc hungarian" for variable prefix explanation.
