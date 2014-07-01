function mFlattened = FlattenSpatialElements(tsUnflattened)

%
% mFlattened = FlattenSpatialElements(tsUnflattened);
%
% Turns a t x m x n time series into a t x (m*n) matrix.
%
% Khan  03/25/09
%
    vSize = size(tsUnflattened);  
    %for it = 1:vSize(1)
    %    iCounter = 0;
    %    for ix = 1:vSize(2)
    %        for iy = 1:vSize(3)
    %            iCounter = iCounter + 1;
    %            tsFlattened(it,iCounter) = tsUnflattened(it,ix,iy);
    %        end
    %    end
    %end
    mFlattened = reshape(tsUnflattened, vSize(1), prod(vSize(2:end)));
end
