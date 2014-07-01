function [oView, voResults] = HemoAnalysisAll(voHemo, voBaseROIs, voDepthBins, nBoots, oView, varargin)

% oView = HemoAnalysisAll(voHemo, voBaseROIs, voDepthBins, nBoots, oView, varargin);
%
%
%
% Khan 11/09/2011

%% Default params
HemoInit

%% Initialize
global tsSliceBlock
RemoveLamHrfData;

%% Main
for oHemo = NumStruct(voHemo)
    cds(oHemo)
    
    if oHemo.iNum > 1
        oView = InitHidden('Volume', 'Timed','SliceBlock');
    else
        if defined('tsSliceBlock')
            Default oView = InitHidden('Volume', 'Timed');
        else
            Default oView = InitHidden('Volume', 'Timed', 'SliceBlock');
        end
    end
    
    CombineHemoROIs(oHemo);
    %%
    for oROI = voBaseROIs
        pROI = FileExt(SessionDir('Volume', 'ROIs', oROI), '.mat');
        if ~isFile(pROI)
            pGray = FileExt(SessionDir('Gray', 'ROIs', oROI), '.mat');
            if ~isFile(pGray)
                Str(pGray, pROI, 'DNE');
                continue
            else
                copyfile(pGray, pROI)
            end
        end
        oLoaded = load(pROI);
        oLoaded = oLoaded.ROI;
        if isempty(oLoaded)
            Str('Warning: Empty ROI', oROI);
            keyboard;
        end
    end
    %%
    for oROI = voBaseROIs
        TextWaitbar(oROI, oHemo);
        try
            if nargout > 1
                [oView, voResults] = HemoAnalysis(oHemo, oROI, oView, nBoots, voDepthBins, 'Mark', 'Save', 'Curve', 'Thick', varargin{:});
            else
                
                oView = HemoAnalysis(oHemo, oROI, oView, nBoots, voDepthBins, 'Mark', 'Save', 'Curve', 'Thick', varargin{:});
                
            end
        catch
            Str(oROI, 'failed');
        end
    end
    clear global
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
