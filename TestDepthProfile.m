% function TestDepthProfile

% TestDepthProfile;
%
%
%
% Khan 02/23/2012
 
%% Default params
%% Initialize
% o = load('/export/data/mri/Anatomy/
[VOLUME{1}, o] = LoadNormDepthMap('');
% x = o.vNormMap;
tsSliceBlock = LoadSliceBlock;

y1 = mean(tsSliceBlock,2);

% [~, tSeries] = percentTSeries(VOLUME{1}, 1, 1);
% y1 = reshape(tSeries, 18, 8, []);
y = squeeze(nanmax(y1,[],1));

x = o.vNormMap;
mm = minmax(x);

x2 = linspace(mm(1), mm(2), 30);


for ii = 1:length(x2)
    vbGood = abs(x-x2(ii)) < 0.25/2;
    y2(ii) = nanmean(y(vbGood));
end

%%
figure; plot(squeeze(nanmean(y1,3)));
figure; plot(x2,y2)
% end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
