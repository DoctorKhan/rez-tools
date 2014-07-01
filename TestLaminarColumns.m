% function TestLaminarColumns

% TestLaminarColumns;
%
%
%
% Khan 01/17/2012
 
%% Default params
Default oView

%% Initialize
HemoInit

%% Main
tic; [oStats, oData, oMaps, oView] = LaminarColumns(oView, oGreene, 1.5); toc
%%
Destruct oStats
Destruct oData
%%
gi = GrayIndices;
% Debug
% vbHigh = vMean == 31;
% cvInds{vbHigh}
% intersect(cvInds{vbHigh}, gi)
% d=cvDepths{vbHigh}
% cvHist{vbHigh}
% cvBins{vMean == 31}
coords = ind2sub3d(cvInds{13103});
oView = newROI(oView, 'Low Std', 'select', 'r', coords);
saveAllROIs(oView, 'local');
%%
figure; subplot(2,2,1); hold on;
c(100:102) = 'rgb'; nCols = length(c);

for ii = 100:102
	v = mean([cvBins{ii};circshift(cvBins{ii}, -1)]);
	plot(v(1:end-1), cvHist{ii}, [c(ii) 'o-']);
end

FixFigLimits; y = ylim; ylim([0 y(2)]);
xlabel('Depth (Voxels)'); ylabel('D = Voxel Count at Depth')
title(Str(nCols, 'Typical Columns'));
subplot(2,2,3); Hist(vStd); xlabel('S = Standard Deviation of D in Column'); ylabel('Column Count')
subplot(2,2,2); plot(vMean, 1:length(vMean), '.'); ylabel('C = Column'); xlabel('M = Mean of D in Column');
subplot(2,2,4); Hist(vMean); xlabel('M = Mean of D in Column'); yla	bel('Column Count')

%%
figure; subplot(2,2,1); Hist(Finite(vQuality)); x = xlim; y = ylim;
xlabel Quality; ylabel Count; title Q=StdDev/Mean
subplot(2,2,3); Hist(Finite(vQuality2)); xlim(x); ylim(y);
xlabel('Quality (Fixed Bins)'); ylabel Count;

%% Identify bad columns
vCI = CalcConfidenceIntervals(vQuality);
vbBad = vQuality > vCI(2);

oDepth.Good = cvDepths(~vbBad);
oDepth.Bad  = cvDepths(vbBad);

%%
subplot(2,2,2); Hist([oDepth.Good{:}]);  
x = xlim; y = ylim; title('Good depths (Q<95% CI)')
subplot(2,2,4); Hist([oDepth.Bad{:}]);
xlim(x); title('Bad depths')

%%
viBad = unique([cvInds{vbBad}]);
mBadCoords = ind2sub3d(viBad);
oView = newROI(oView, 'BadCols', 1, '', mBadCoords);

%% Note: type "doc hungarian" for variable prefix explanation.
% vMedian = median(mHist);
% vQualMed = vStd./vMedian;
% Hist(vMedian);
% mHist = Hist(mDepth(:,500),15);
% [x mHist z] = Foliate(ind2sub3d(voCols(101).value));
% figure; plot3(x,mHist,z)
% end % Function