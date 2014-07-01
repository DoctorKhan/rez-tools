% function TestFigDepthMap

% TestFigDepthMap;
%
%
%
% Khan 11/09/2011

%% Default params


%% Initialize
dx = 0.5;

%% Main
oView = InitHidden('Volume');
oView = NormalizedDepthMap(oView, '', 'Load');
oView = loadAnat(oView);

viDim = GetDimFromAnat;

volmap = nan(viDim);
vi = coords2Indices(oView.coords, viDim);
tMap(vi) = oView.map{1};

%%
iSlice = 270;

b = double(squeeze(tMap(:,iSlice-1:iSlice+1,:)));
m = BoundingBox(log2sub3d(~isnan(b)));

pad = 5;

m = m + pad*[-1 1; 0 0; -1 1];

% [X, Y]   = meshgrid(x1:x2, y1:y2);
% [XI, YI] = meshgrid(x1:dx:x2, y1:dx:y2);

Z = b(m(1,1):m(1,2), m(2,1):m(2,2), m(3,1):m(3,2));
Z(isnan(Z)) = 2;

mAnat = 3*double(oView.anat)/255 - 1;
mAnat(isnan(tMap)) = 2;

mSlice = squeeze(mAnat(m(1,1):m(1,2), iSlice, m(3,1):m(3,2)));
mSlice = interp2(mSlice,2);
pic(mSlice)

%%
c = squeeze(Z(:,2,:));
pic(c); colormap jet; hold on
contour(c,[0 1], 'k', 'LineWidth', 2);
hold off;
%%
zInt = interp3(Z, 2, 'spline');

%%
b = squeeze(zInt(:,2,:));
b = flipdim(flipdim(b, 2),1);
mSlice = flipdim(flipdim(mSlice, 2),1);
ImageOverlay(mSlice, b, '', '', .75); hold on


% pic(a); colormap jet; hold on

b(abs(b) < .05) = 0;
contour(b,[ 0 1 ], 'k', 'LineWidth', 2);

% end % Function

%%
% k = 1.1*t;
% k(k>1) = 1;
% imagesc(k); axis image
%% Note: type "doc hungarian" for variable prefix explanation.
