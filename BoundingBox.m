function [mBounds vLower vUpper] = BoundingBox(mCoords, varargin)

% [mBounds vLower vUpper] = BoundingBox(mCoords, varargin);
%
% Ress    08/2008 - Creator
% Khan 02/06/2011 - Handles logical matrix now.

%% Argument Handling

% Extract from object classes
if isRawiv(mCoords)
    [tData, mBox, vScale] = Destruct(mCoords);
    mCoords = tData;
elseif isMesh(mCoords)
    mCoords = mCoords.vertices;
elseif isa(mCoords, 'Seg')
    mCoords = mCoords.Gray;
end

% Convert to logical
if isnumeric(mCoords) && is3d(mCoords)
    if Option('fin')
        mCoords = isfinite(mCoords) & mCoords ~= 0;
    else
        if numel(unique(mCoords(:))) == 2
            mCoords = mCoords == max(mCoords(:));
        else
            mCoords = abs(mCoords) < 0.5;
        end
        if mCoords(1) 
            mCoords = ~mCoords;
        end
    end
end

% Logical to coordinate matrix
if islogical(mCoords)
    tbCoords = mCoords;
    mCoords = log2sub3d(mCoords);
    if isempty(mCoords)
        disp('Warning: undefined bounds for false logical matrix.'); 
        mCoords = log2sub3d(~tbCoords);
    end
end

% Coordinate transform to voxel units, if necessary.
if defined('mBox')
        mCoords = Sub2Box(mCoords, mBox, vScale);
end
    
%% Initialize
nDims = NumC(mCoords);
mBounds = zeros(2, nDims); % preallocate

if nDims > 5
    disp('Dimensions of coordinates >5 -- coordinate input must nmCoords x numberPoints')
    return
end

%% Main
if isLongVector(mCoords) % size vector input
    mCoords = [ 1 1 1 ; HorzVec(mCoords)];
end

mCoords = HorzMat(mCoords, 'reshape');

vLower = min(mCoords, [], 2)';
vUpper = max(mCoords, [], 2)';

mBounds = [vLower; vUpper];

end %function

%% Note: type "doc hungarian" for variable prefix explanation.
