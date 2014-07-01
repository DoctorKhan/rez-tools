function [mzInnerSlice, mzOuterSlice, mzDomainSlice] = GetSliceFrom3D(mInner, mOuter, mDomain, iSlice, iWidth)

% [mzInnerSlice, mzOuterSlice, mzDomainSlice] = GetSliceFrom3D(mInner, mOuter, mDomain, iSlice, iWidth);
% 
% 
% 
% Khan 12/07/2009

% Get indices of the points around the slice
viSliceInner = abs(mInner(3,:) - iSlice) < iWidth;
viSliceOuter = abs(mOuter(3,:) - iSlice) < iWidth;
viSliceGray  = abs(mDomain(3,:) - iSlice) < iWidth;
hist(double(mInner(3,viSliceInner)))

mzInnerSlice = ComplexPoint(single(mInner(1:2,viSliceInner)));
mzOuterSlice = ComplexPoint(single(mOuter(1:2,viSliceOuter)));
mzDomainSlice = ComplexPoint(single(mDomain(1:2,viSliceGray)));

vOrigin(1) = round(mean([min(real(mzOuterSlice)); max(real(mzOuterSlice))]));
vOrigin(2) = round(mean([min(imag(mzOuterSlice)); max(imag(mzOuterSlice))]));
vOrigin = complex(vOrigin(1), vOrigin(2));
% Scale nodes to voxel size
% mzDomainSlice = mzDomainSlice .* repmat(mmPerVox,1,size(mzDomainSlice,2));

nPtsInner = length(mzInnerSlice);
nPtsOuter = length(mzOuterSlice);
nPtsDomain = length(mzDomainSlice);

% Shift to origin
mzInnerSlice = mzInnerSlice - repmat(vOrigin,1,nPtsInner);
mzOuterSlice = mzOuterSlice - repmat(vOrigin,1,nPtsOuter);
mzDomainSlice = mzDomainSlice - repmat(vOrigin,1,nPtsDomain);

end
