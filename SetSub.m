function oRawiv = SetSub(oRawiv, xIn, sName)

% SetSub(oRawiv, xIn);
%
% Set subfield.
%
% Khan 04/04/2012

%% Default
Default sName = inputname(2);

%% Main
if isobject(oRawiv) && ~isSub(oRawiv, sName)
    oRawiv.addprop(sName);
end

oRawiv.(sName) = xIn;

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
