function bool = isOutside(a, b, c)

% bool = isOutside(a, b, c);
%
% Checks if b is between a and c.
%
% Khan 03/19/2012

%% Defaults
Default c = []

if is3d(b)
    [mCoords, viDim] = log2sub3d(b);
    bool = sub2log3d(isOutside(a, mCoords, c), viDim);
    return
end

vBounds = [a c];

if isCoord(b)
    for iDim = 1:3
        vbOut(iDim,:) = isOutside(vBounds(:,iDim), b(iDim,:));
    end
    bool = b(:,any(vbOut));
    return
end
%% Main
vBounds = sort(vBounds);

a = vBounds(1); 
c = vBounds(2);

bool = (b < a) | (b > c);

end
 
%% Note: type "doc hungarian" for variable prefix explanation.
