function [tSdf, tMedian] = MedianSignFilter3d(tSdf, nReps)

% [tFiltered, tMedian] = MedianSignFilter3d(tSdf);
%
%
%
% Khan 04/20/2012

%% Default params


%% Initialize
if ~regexp(which('prctile'), 'stats')
    addpath('/opt/matlab-2010a/toolbox/stats', '-begin')
end

%% Main
for jj = 1:nReps
    oQuality = SdfQa(tSdf); % Quality check
    tFiltered = tSdf;
    
    %% Main
%     for iDim = 2:3
%         tMedian = permute(tMedian, [1 3 2]);
            tMedian = medfilt3(tSdf);
        tbBad = abs(tMedian - tSdf) > 1.3;
        
        tFiltered(tbBad) = -tFiltered(tbBad);
%     end
    
    % Check
    pch = SdfQa(tSdf, oQuality); % Quality check
    
    if pch > 0
        tSdf = tFiltered;
    else
        break;
    end
    
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
