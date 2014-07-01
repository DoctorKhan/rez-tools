function x2 = UnitConvert(v1, v2, x1)

% x2 = UnitConvert(v1, v2, x1);
%
% Converts between units which are linearly related.
%
% Khan 01/08/2011

%% Main
vFit = polyfit(v1, v2, 1);
x2 = polyval(vFit, x1);

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
