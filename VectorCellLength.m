function vLength = VectorCellLength(cVectorCells)

%
% vLength = VectorCellLength(cVectorCells);
% 
% Returns a vector of the size of each element of the input cell.
%
% Khan 1/2009
%

for i = 1: length(cVectorCells)
    v = cVectorCells{i};
    vLength(i) = length(v);
end

end