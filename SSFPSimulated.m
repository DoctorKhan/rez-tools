function [cSimulated, cAveSimulated] = SSFPSimulated(fVolumeTR, fAlpha, fT1, fT2, fBeta, iFrames, iSlices, iInterleaves)
fTR = fVolumeTR / (iSlices * iInterleaves);
fTotalTime = fVolumeTR*iFrames;
iIterations = floor(fTotalTime / (2*fTR)) + 1;
[SS, cSimulated.ordinate] = SSFPDiscrete(fTR, fAlpha, fT1, fT2, fBeta, iIterations);

cSimulated.ordinate = cSimulated.ordinate/SS;
for i = 1:length(cSimulated.ordinate)
    cSimulated.time(i) = (i-1)*fTR/1000;
end

%mReshapedSeries = length(cSimulated.ordinate
cAveSimulated = cSimulated;
end