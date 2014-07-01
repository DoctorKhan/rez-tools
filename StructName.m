function sName = StructName(oStruct, varargin)

% oStruct = StructName(oStruct);
%
%
%
% Khan 09/27/2011

%% Default params


%% Initialize
if isempty(oStruct)
    sName = [];
    return
end

oStruct = Obj2Struct(oStruct);
csCheck = {'filename', 'name', 'sHemi', 'sSubject'};

%% Main
if isstruct(oStruct)
    for csField = csCheck, sField = csField{1};
		if isfield(oStruct(1), sField)
			if numel(oStruct) > 1
				sName = {oStruct.(sField)};
			else
				sName = oStruct.(sField);
			end
			return
		end
    end
end

if ischar(oStruct)
	sName = oStruct;
elseif iscell(oStruct) && Option('once')
	sName = oStruct{1}; 
else
	sName = '';
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
