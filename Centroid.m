function vCenter = Centroid(mIn)

% vCenter = Centroid(mIn);
%
%
%
% Khan 01/02/2012
 
%% Default params


%% Initialize
switch class(mIn)
    case 'logical', mIn = log2sub3d(mIn);
    case 'RawMesh', mIn = mIn.vertices;
    case 'Rawiv'
        [tData, vScale, mBox(1,:)] = Destruct(mIn);
        mData = log2sub3d(tData);
        mIn = MatrixVectorSum(MatrixVectorProd(mData, vScale), mBox(1,:));
end

%% Main
mIn = HorzMat(double(mIn));
mIn = NanMean(mIn, 2);
vCenter = HorzVec(mIn);

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
