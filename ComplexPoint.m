function out = ComplexPoint(in)

%
% out = ComplexPoint(in);
%
% Convert vector points to complex points
%
% Khan 09/13/09
%

if iscomplex(in)
    out = in;
    return;
end

s = size(in);

if s(2) == 2
    out = complex(in(:,1),in(:,2));
else
    out = conj(ComplexPoint(in')');
end

end
