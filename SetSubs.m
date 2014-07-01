function oRawiv = SetSubs(oRawiv, varargin)

% oRawiv = SetSubs(oRawiv, varargin);
%
%
%
% Khan 04/04/2012

%% Main
for oArg = Str2Struct(varargin)
    sName = inputname(oArg.iNum + 1);
    xVal = evalin('caller', [sName ';']);
    oRawiv = SetSub(oRawiv, xVal, sName);
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
