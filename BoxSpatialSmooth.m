function smoothed = BoxSpatialSmooth(m, iWindow)

%
% smoothed = BoxSpatialSmooth(m, iWindow);
%
% Smooths a matrix (or each matrix in a timeseries) with a moving average
% iWindow x iWindow  box. Doesn't have edge effect defects due to
% convolution.
%
% Khan  03/24/09
% Khan 02/25/2010 - Only show waitbar if numel is big.

s = size(m);


% If it is a timeseries, spatially smooth (with a window) each matrix
% in the series.
if ists(m)
    bWb = numel(m) > 2752512;
    if bWb
%         wbProgress = waitbar(0, 'Acquiring Fit Parameters...');
    end
    
    ProgBar('Smoothing...');
    
    maxt = s(1);
    for it = 1:maxt
        if bWb
%             waitbar((it-1)/(maxt-1), wbProgress, ['Boxcar spatial smoothing... ', num2str(it), '/', num2str(maxt)]);
            ProgBar(it/maxt);
        end
        msm = nanmoving_average2(squeeze(m(it,:,:)), iWindow, iWindow);
        smoothed(it,:,:) = msm(:,:);
    end
    if bWb, close(wbProgress); end
else
    % Spatially smooth the matrix with an iWinodw x iWindow moving
    % window.
    smoothed = nanmoving_average2(m,iWindow, iWindow);
end
end

%% Note: type "doc hungarian" for variable prefix explanation.
