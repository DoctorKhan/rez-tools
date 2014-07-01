function bOut = isSub(oStruct, sField, value2check)

% bOut = isSub(oStruct, sField, value2check);
%
% Like isfield, but can also check if field equals value2check.
%
% Khan 12/27/2011 - original "isField"
% Khan 04/23/2012 - Renamed function.

%% Main
try 
    fieldVal = oStruct.(sField);
    bOut = notDefined('value2check') || isequal(fieldVal, value2check);
catch
    bOut = false;
end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
