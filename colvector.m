function v = colvector(v)

%
% v = colvector(v);
%
% Force it to be a column vector.
%
% Khan  07/29/09
%

if isvector(v) && size(v,2) ~= 1
    v = v';
end

end