% function LaminarHRFAnalysisAll

% LaminarHRFAnalysisAll;
%
%
%
% Khan 07/18/2011

%% Default params
HemoInit

%% Initialize
nBoots = 1000;
%% Main
for oHemo = voHemo(1)
    sSession = oHemo.sSession;
    sSubject = oHemo.sSubject;
    
    cds(sSession);
    period = HRFInfo('period');
    
%     oView = mrVista('Volume');
    
    try
        oResults = voResults.(oHemo.sSubject);
        oView = oResults.oView;
    catch
        load mrSESSION
        oResults.oView=initHiddenVolume;
        LoadPreliminaries;
    end
    
    [tsSliceBlock, mbFinite] = LoadSliceBlock(oView, '', 1);
      
    [oView, vNormMap] = NormalizedDepthMap(oView, Struct(sSubject, sRegion), 'force');
    
    % Good voxels mask
    vbGoodDepths = isfinite(vNormMap);
    mbGood = mbFinite & repmat(vbGoodDepths, [size(mbFinite, 1) 1]);
    vbGood = any(mbGood);
    
    for oBaseROI = voBaseROIs(1)
        oROINames  = load(['csROIs.' oBaseROI.sROI, '.mat']);
        voROINames = cell2struct(oROINames.csROIs, 'sROI')';
        
        for oROIName = voROINames % iterate over CNRs
           sThreshROIName = oROIName.sROI;
            
            % Load ROI
            oThreshedROI  = getfield(load(SessionDir('Gray', 'ROIs', sThreshROIName)), 'ROI');
            
            % Mark it through depth
            [mLamROICoords, vbROIMask] = MarkLaminarROI(oView, oThreshedROI);
            
            vbROIMask = vbROIMask & vbGood;
            viDim = size(tsSliceBlock);
            viDim(3) = total(vbROIMask);
            
            tsROI = nan(size(tsSliceBlock));
            tsROI = tsSliceBlock(:,:,vbROIMask);
            vROIDepth = vNormMap(vbROIMask);
            
            %% Stack session events
            [tsBinned, vBinDepths] = StackJitteredSessionEvents(tsROI, vROIDepth, vbROIMask, sThreshROIName, 'force');
            % tsSliceBlock = NormSliceBlockByMeanGray(tsSliceBlock, trialPeriod, vbDomain);
            
            % Bootstrap & Analysis
            oBootAnalysis = LaminarHRFAnalysis(tsBinned, period, nBoots, 'Norm', sThreshROIName, 'force');
            
            % Plot
            ForEachFieldOf(oBootAnalysis, @PlotWithError, {oBootAnalysis, 'fieldname', vBinDepths, '', oThreshedROI.comments})
        end
    end
    
    voResults.(sSubject) = oResults;
end

% end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
