function mNormAveTimeSeries = NormTimeSeries(sDir)
sPfileDir = fullfile('/', 'mnt', 'proj', 'vision', 'MRI', 'Raw', sDir, 'Raw');
vsScanParams = GetScanParams(sPfileDir);
iRun = 1;
iSlice = 2; iRange = 10;
iMidX=floor(vsScanParams(iRun).fullSize(1)/2);
iMidY=floor(vsScanParams(iRun).fullSize(2)/2);
mTimeSeries = LoadRecon(vsScanParams(iRun), fullfile(sPfileDir, 'Pfiles', vsScanParams(1).PfileName), iSlice);
vTransverseMagnetization = mTimeSeries(:,iMidX,iMidY);
iLastFrame = vsScanParams(iRun).totalFrames;
iFirstSSFrame = floor(iLastFrame/2);
iMinX = iMidX - floor(iRange/2); iMaxX = iMinX + iRange - 1;
iMinY = iMidY - floor(iRange/2); iMaxY = iMinY + iRange - 1;
iX = iMinX; iY = iMinY;
SS = mean(mTimeSeries(iFirstSSFrame:iLastFrame,iX,iY));
for iT = 1:iLastFrame
    mNormAveTimeSeries(iT, iX,iY) = mTimeSeries(iT,iX, iY)/SS;
end
end