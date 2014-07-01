function mRCI = ind2sub3d(viSize, viIndices)

% mRCI = ind2sub3d(viSize, viIndices);
% 
% Returns a 3xN matrix with the row, column, and set coordinates of a 1d
% index.
% 
% Khan 12/08/2009

%% Defaults
if nargin == 1
	viIndices = viSize;
	viSize = GetDimFromAnat;
end
%% Argument handling
% Accept reverse argument order when unambiguous
if length(viSize) ~= 3 && length(viIndices) == 3
    [viSize viIndices] = swap(viSize, viIndices);
end
    
if isstruct(viSize)
    oGrid = viSize;
    viSize = [oGrid.nY, oGrid.nX, oGrid.nZ];
end

%% Main
iStackSize = prod(viSize(1:2));
viSet = 1 + floor(viIndices / iStackSize);
ind2d = rem(viIndices, iStackSize);
viSet(ind2d == 0) = viSet(ind2d == 0) - 1;
ind2d(ind2d == 0) = iStackSize;
% if ind2d == 0
%     viSet = viSet - 1;
%     viRow = viSize(1);
%     viColumn = viSize(2);
% else
    [viRow, viColumn] = ind2sub(viSize(1:2), ind2d);
% end

mRCI = [vectorize(viRow)'; vectorize(viColumn)'; vectorize(viSet)'];

end %function

