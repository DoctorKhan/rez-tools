function bOut = isField(oStruct, sField, xVal)

% bOut = isField(oStruct, sField, xVal);
%
% Like isfield, but can also check if field equals xVal.
%
% Khan 12/27/2011

%% Default params


%% Initialize


%% Main
try
    bOut = isfield(oStruct, sField) && ...
        (notDefined('xVal') || isequal(oStruct.(sField), xVal));
catch
    bOut = false;
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
