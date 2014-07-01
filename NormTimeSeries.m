function [cNormAveTimeSeries, cNormTimeSeries] = NormTimeSeries(sDir, iRun, iSlice, iRange)
%% default params
if ~exist('iRun', 'var')
    iRun = 1;
end
if ~exist('iSlice', 'var')
    iSlice = 2;
end
if ~exist('iRange', 'var')
    iRange = 10;
end
%% 
sRawPath = GetRawPath(sDir);
vsScanParams = GetScanParams(sRawPath);
mTimeSeries = GetTimeSeries(sDir, iRun, iSlice);

iMidX=floor(vsScanParams(iRun).fullSize(1)/2);
iMidY=floor(vsScanParams(iRun).fullSize(2)/2);

iMinX = iMidX - floor(iRange/2); iMaxX = iMinX + iRange - 1;
iMinY = iMidY - floor(iRange/2); iMaxY = iMinY + iRange - 1;
iLastFrame = length(mTimeSeries(:,1,1));
%%

%mReducedTimeSeries = mTimeSeries(:, iMinX:iMaxX, iMinY:iMaxY);
for iX = iMinX:iMaxX;
    for iY = iMinY:iMaxY;
        vNormTimeSeries = NormalizedTimeSeries(mTimeSeries(:,iX, iY));
        if ~exist('mNormTimeSeries', 'var')
            mNormTimeSeries = vNormTimeSeries;
        else
            mNormTimeSeries = [ mNormTimeSeries, vNormTimeSeries ];
        end
    end
end
%%
dt = vsScanParams(iRun).framePeriod;
for iT = 1:iLastFrame
    cNormAveTimeSeries.time(iT) = (iT-1)*dt + dt/2
    cNormAveTimeSeries.ordinate(iT) = mean(mNormTimeSeries(iT,:));
end

cNormTimeSeries.ordinate = NormalizedTimeSeries(mTimeSeries(:,iMidX,iMidY));
cNormTimeSeries.time = cNormAveTimeSeries.time;

end