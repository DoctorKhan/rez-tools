function hOut = pic(mImage, hIn, contrast)

%
% hOut = pic(mImage, hIn, contrast);
%
%
%
% Khan 09/30/09
%

if defined('hIn') && islogical(hIn) && ismatrix(hIn)
    mbMask = hIn;
    mImage = MaskImage(mImage, mbMask);
end

mImage = squeeze(mImage);

vSize = size(mImage);
if length(vSize) == 3
    if vSize(1) > 10, nPlots = 10; else nPlots = vSize(1); end
    [nRows, nCols] = SubplotDims(nPlots);
    
    for iPic = 1:nPlots
        hOut = subplot(nRows,nCols,iPic);  colormap gray;
        imagesc(squeeze(mImage(iPic,:,:)));
    end
else
        hOut = figure;
    try
        imagesc(mImage, contrast);
    catch
      imagesc(mImage);
    end
end

 axis image; colormap gray; colorbar

end

%% Note: type "doc hungarian" for variable prefix explanation.
