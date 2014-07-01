function vOutput = BlockMean(vData, iBlockLength)

%
% vOutput = BlockMean(vData, iBlockLength);
%
%
%
% Khan 01/09/09
%

iNumOfBlocks = floor(length(vData) / iBlockLength);
iTruncLength = iNumOfBlocks*iBlockLength;
vTruncData = vData(1:iTruncLength);
mReshapedData = reshape(vTruncData, iBlockLength, iNumOfBlocks);
vOutput = mean(mReshapedData,1);
end
