function out = VectorPoint(in)

%
% out = VectorPoint(in);
%
% Convert complex points to vector points
%
% Khan 09/13/09
%

if isreal(in)
    out = in;
    return;
end

s = size(in);

out = [real(in(:)), imag(in(:))];

if s(2) > s(1)
    out = out';
end

end
