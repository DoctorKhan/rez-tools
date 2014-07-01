function PlotPointsOnImage(x, y, mImage, sStyle, nDivs, varargin)

% PlotPointsOnImage(x, y, mImage, sStyle, nDivs, varargin);
%
%
%
% Khan 06/01/2011

%% Default params
Default sStyle = "."

%% Initialize
mImage = squeeze(mImage);

%% Main
imagesc(mImage); colorbar; axis image; colormap jet; hold on; 

% Default nDivs = 8;
% mm = minmax(mImage);

% r = diff(mm)/nDivs;
% divInc = 10^round(log10(r));

% viDivs = [-divInc:-divInc:mm(1) 0:divInc:mm(2)];
% viDivs(viDivs < mm(1)) = [];

viDivs = [-2 0 2];
contour(mImage, viDivs, 'w'); hold on;
plot(x,y,sStyle, varargin{:});

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
