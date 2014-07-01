
% TestHRFTimeSeries;
%
%
%
% Khan 07/25/2011

%% Default params


%% Initialize


%% Main
mrVista('Volume');
VOLUME{1} = selectDataType(VOLUME{1}, 'Timed');
% [VOLUME{1}, oMaps ] = NormalizedDepthMap(VOLUME{1}, 'force');
VOLUME{1} = loadParameterMap(VOLUME{1}, '/export/data/mri/LaminarHemo/031010sim/Volume/Timed/NormDepthMap.mat');

%%
depth = VOLUME{1}.map{1};
hrf1 = SimDepthHRF(depth);

hrf = [];
for ii=1:8
    hrf = [hrf; hrf1];
end

for ii=1:9
    hrfn = hrf + 0.15*randn(size(hrf));
    savetSeries(hrfn, VOLUME{1}, ii, 1);
end


ts = [];
for ii = 1:9
    ts1 = loadtSeries(VOLUME{1}, ii, 1);
    nTrials = size(ts1, 1);
    ts = cat(2, ts, reshape(ts1, 18, nTrials/18, []));
end

figure; plot(mean2(ts));

%%
HemoInit
rm SliceBlock
oBins = BinBounds;
vBins = [oBins.middle];
oResults = LamHRFMultiROI(oSim, voBaseROIs(1), 80, BinBounds, 1:9, 1000);

a = load('SliceBlock');
% plot(mean2(a.tsSliceBlock))

b = loadtSeries(VOLUME{1}, 1);
% plot(nanmean(b,2));
%%
viBins = [oResults.Column.voBins.iBin];
vBins = [oResults.Column.voBins.middle];

%%
close all
mSim = SimDepthHRF(vBins);
for ii = 1:25, [voSimAnal(ii)] = HRFAnalysis(mSim(:,ii), 27); end

tSimParams = struct2mat([voSimAnal.sParams]); % Field x coord x bin
%fwhm, initdip, peak, under


oSimAnal = HRFStructArray2Struct(voSimParams);
oBootAnal = oResults.Column.Boot;

ForEachFieldOf(oBootAnal, @PlotWithError, {oBootAnal, 'fieldname', vBins})


t2 = reshape(permute(tSimParams, [ 2 1 3]), 8, []);


for ii = 2:8
    figure(ii-1)
    hold on;
    plot(vBins, t2(ii,:), 'r');
end

%%

%
%           vFWHM: [0.1935 4.4100]
%        vInitDip: [1.5900 -0.0602]
%           vPeak: [6.7400 0.3863]
%     vUndershoot: [13.9000 -0.1086]
    %
figure; plot(vBins, vSimPeaks, vBins, vPeaks);
% figure; plot(PercentChange(vSimPeaks, vPeaks));

% %%
% VOLUME{1} = LoadLaminarIndices(VOLUME{1}); % then switch to timed.
% viDim = GetDimFromAnat;
% tVol = nan();
% tVol(VolumeIndices) = VOLUME{1}.map{1};
% lam = VOLUME{1}.laminarIndices;
% for ii = 1:length(VOLUME{1}.laminarIndices), lamd{ii} = tVol(lam{ii}); end
% [c, I] = max(cellfun(@Fin, lamd));
% % lamd{I}
% mColCoords = ind2sub3d(lam{I}, viDim);
% 
% %%
% VOLUME{1} = newROI(VOLUME{1}, 'Column' , 'select', '', mColCoords);
% saveAllROIs(VOLUME{1})
% 
% %% Note: type "doc hungarian" for variable prefix explanation.
