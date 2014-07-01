function fsAnalyze = DFAnalyze(fsDF)

ts = fsDF.ts;
tsFieldMaps = fsDF.tsFieldMaps;
mFitParams = fsDF.mFitParams;
tsWeights = fsDF.tsWeights;
% Get number of frames
s = size(tsFieldMaps);
nFrames = s(1);

% This is the data from the fit
tsFitData = ConstructFittedData(mFitParams, s(2), s(3));
%ts = tFieldMaps(1:2, :,:);

tsResiduals = tsFieldMaps - tsFitData;
tsResidualsWtd = tsResiduals .* tsWeights;
tsResidualsWtdSq = abs(tsResidualsWtd).^2;
tsMagFieldMapSq = abs(fsDF.tsFieldMaps).^2;
tsMagFieldMapWtdSq = abs(fsDF.tsFieldMapsWtd).^2;
for it = 1:nFrames
    [chiSqGOF(it), pValue(it), stats(it)] = chi2gof(tsResidualsWtd(it,:));
    rmsWtdError(it) = sqrt(nanmean(tsResidualsWtdSq(it,:)));
    rmsWtdFieldMap(it) = sqrt(nanmean(tsMagFieldMapWtdSq(it,:)));
    rmsMagFieldMap(it) = sqrt(nanmean(tsMagFieldMapSq(it,:)));
    variance1(it) = rmsWtdError(it) / rmsWtdFieldMap(it);
    variance2(it) = rmsWtdError(it) / rmsMagFieldMap(it);
end
for i = 1:3
    meanFitParams(i) = mean(mFitParams(i,:));
end
%m = ThresholdMask(ts, 0.05);
%m = m(2:end, :, :);

%tsFieldMaps = tsFieldMaps .* m;

%mWeights49 = squeeze(tsWeights(49,:,:));
%mWeights49Norm = mWeights49 / max(mWeights49(:));
%mFit49 = squeeze(tsFitData(49,:,:));
%mFieldMap49 = squeeze(tsFieldMaps(49,:,:));
%clf; hold on; surf(mFieldMap49.*mWeights49); surf(mFit49);

%dts = ts(1:2:end-1, :, :) - ts(2:2:end, :, :); %change in fieldmap between frames
%noise = abs(mean(mean(squeeze(std(dts(:, 64-3:64+3, 64-3:64+3), [], 1)))))

%mts = squeeze(nanmean(ts, 1)); %average fieldmap
%plot(abs(mts(64,:)))
%imagesc(abs(mts) > 10*noise); axis image

%mask = abs(mts) > 10*noise; % 128 x 128
%mask = mask(:); % 16384x1 logical

%compute notExplained for frame 49.
%residue49wt = (mFieldMap49 .* mWeights49) - mFit49;
%mFit49wt = mFit49.*mWeights49;
%notExplained = sqrt(nanmean(nanmean(residue49.^2))) / sqrt(nanmean(nanmean(mFieldMap49wt.^2)))
%notExplained = sqrt(nanmean(residue49wt(mask).^2)) / sqrt(nanmean(mFit49wt(mask).^2))

%plot frame 49 field map
%x=-64:63; x = x + 0.5;
%[xx,yy] = meshgrid(x);
%surf(xx, yy, mFieldMap49)

%plot frame 49 field map masked with fit
%mFieldMap49Masked = mFieldMap49;
%mFieldMap49Masked(~mask) = NaN;
%mFieldMap49MaskedWtd = mFieldMap49Masked .* mWeights49;
%mFieldMap49Wtd = mFieldMap49 .* mWeights49;

%mFit49 = squeeze(tsFitData(49, :, :));

% We must reshape a 99x128x128 (time, x, y) into 99x(128^2) to compute the
% residuals.
%tss = reshape(tsFieldMaps, [nFrames, prod(s(2:end))]);
% Potential problem:
% VectorCellLength(RemoveNaNMatrix(tss)) = 12851       12851       12851
% 12850       12851 ...
% #4 and #25 have one less element.

% Do the same for the fit data
%fss = reshape(tsFitData, [nFrames, prod(s(2:end))]);

% Compute the residuals and then remove NaN elements. the result is stored
% in a cell structure (index = time), where each element is a row vector.
%cResiduals = RemoveNaNMatrix(fss - tss);

%fSfit.mFit49 = mFit49;
%fSfit.mFieldMap49 = mFieldMap49;
%fSfit.mFieldMap49Wtd = mFieldMap49Wtd;
%fSfit.mFieldMap49Masked = mFieldMap49Masked;
%fSfit.mFieldMap49MaskedWtd = mFieldMap49MaskedWtd;
%fSfit.tsFitData = tsFitData;
%fSfit.mWeights49 = mWeights49;
%fSfit.mWeights49Norm = mWeights49Norm;
%fSfit.xx = xx;
%fSfit.yy = yy;
fsAnalyze = fsDF;
fsAnalyze.tsFitData = tsFitData;
fsAnalyze.tsResiduals = tsResiduals;
fsAnalyze.tsResidualsWtd = tsResidualsWtd;
fsAnalyze.chiSqGOF = chiSqGOF;
fsAnalyze.pValue = pValue;
fsAnalyze.stats = stats;
fsAnalyze.rmsWtdError = rmsWtdError;
fsAnalyze.rmsWtdFieldMap = rmsWtdFieldMap;
fsAnalyze.variance1 = variance1;
fsAnalyze.variance2 = variance2;
fsAnalyze.meanFitParams = meanFitParams;
end