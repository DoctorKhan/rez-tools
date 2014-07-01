function bool = isBetween(a, b, c)

% bool = isBetween(a, b, c);
%
% Checks if b is between a and c.
%
% Khan 03/19/2012

if isLongVector(a)
    c = a(2);
    a = a(1);
end

bool = ((a <= b) & (b <= c)) | ((a >= b) & (b >= c));

end
 
%% Note: type "doc hungarian" for variable prefix explanation.
