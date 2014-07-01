function varargout = ForEachFieldOf(oStruct, fhFunc, cArgs, vStructsToFoliate)

% varargout = ForEachFieldOf(oStruct, fhFunc, cArgs, vStructsToFoliate);
%
% Calls function fhFunc on each field of oStruct and returns cOut
% corresponding structure. Note argument order.
%
% Example: ForEachFieldOf(oStruct, @CalcStats)
%
% Khan 03/30/2010
% Khan 04/05/2010 - Changed syntax to allow flexible argument placement

%% Argument handling
if notDefined('cArgs')
    cArgs = oStruct;
end

if ~iscell(cArgs)
    cArgs = {cArgs};
end

%% Initialize
csFields = fieldnames(oStruct);
nFields = length(csFields);
nArgs = length(cArgs);
cArgOut  = cell(1, nargout);

for iArg = 1:nArgs
    if strcmp('field', cArgs{iArg})
        cArgs{iArg} = oStruct;
    end
end

if notDefined('vStructsToFoliate')
    vStructsToFoliate = true(1, nArgs);
end

%% Main
for iField = 1:nFields
    sField = csFields{iField};

    cArgsToPass = cArgs;
    
    for iArg = 1:nArgs
        if vStructsToFoliate(iArg) && isstruct(cArgs{iArg})
            cArgsToPass{iArg}  = cArgs{iArg}.(sField);
        end
        if strcmpi('fieldname', cArgs{iArg})
            cArgsToPass{iArg} = sField;
        end
    end
    
    [ cArgOut{1:nargout} ] = fhFunc(cArgsToPass{:});
    
    for iArg = 1:nargout
        varargout{iArg}.(sField) = cArgOut{iArg};
    end
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
