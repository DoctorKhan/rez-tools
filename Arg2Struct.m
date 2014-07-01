function [oStruct, xVal] = Arg2Struct(hFunc, sName, oStruct)

% oStruct = Arg2Struct(hFunc, sName, oStruct);
%
% Extracts the first argument from varargin (of calling function) which 
% satisfies function hFunc. This is then added to structure oStruct with
% fieldname sName.
%
% Khan 06/08/2012
 
%% Default params
Default sName = "sArg"

%% Initialize
v = evalin('caller', 'varargin');
Default xVal

%% Main
iFound = find(CellFun(hFunc, v), 1, 'first');
if ~isempty(iFound)
    xVal = v{iFound};
    oStruct.(sName) = xVal;

    v(iFound) = [];
    assignin('caller', 'varargin', v);
else
    Default oStruct = struct;
end

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
