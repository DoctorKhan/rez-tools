function VistaAnalysis(sType, sOption)

% VistaAnalysis(sType, sType);
%
% Run basic vistasoft analysis
%
% Khan 03/09/2010

%% Defaults
if notDefined('sOption'), sOption = ''; end

%% Main
mrGlobals
if notDefined('INPLANE')
    mrVista
end
%         AutofixFOV;

switch sType
    case 'hrf'
        % Load/compute mean map and initial check
        INPLANE{1}=loadMeanMap(INPLANE{1}); INPLANE{1}=setDisplayMode(INPLANE{1},'map'); INPLANE{1}=refreshScreen(INPLANE{1});
%         INPLANE{1}=computeMeanMap(INPLANE{1},0); INPLANE{1}=setDisplayMode(INPLANE{1},'map'); INPLANE{1}=refreshScreen(INPLANE{1});
        
        keyboard; % Check mean maps
        
        % Motion compensation
        if ~exist('./Between_Scan_Motion.txt', 'file') || strcmp(sOption, 'force')
            % WITHIN scans motion
            % Use nframes - nsmooth/2 as base frame (nsmooth = 5);
            INPLANE{1} = motionCompSelScan(INPLANE{1});
            INPLANE{1} = selectDataType(INPLANE{1}, length(dataTYPES));
            % BETWEEN scans motion
            % Base scan = 1 (closest to Inplane)
            iBaseScan = 1;
            INPLANE{1} = betweenScanMotCompSelScan(INPLANE{1}, iBaseScan, 'hrf');
            INPLANE{1} = refreshScreen(INPLANE{1}); 
        end
        
        % Adjust slice timing
        INPLANE{1} = selectDataType(INPLANE{1}, length(dataTYPES));
        INPLANE{1} = AdjustSliceTimingMod(INPLANE{1}, 0); INPLANE{1} = refreshScreen(INPLANE{1}); 
        
        % Compute average
        INPLANE{1} = selectDataType(INPLANE{1}, length(dataTYPES));
        INPLANE{1} = averageTSeries(INPLANE{1}, 1:length(mrSESSION.functionals)); INPLANE{1} = refreshScreen(INPLANE{1});

        
        % Compute coherence analysis
        INPLANE{1} = selectDataType(INPLANE{1}, 'Timed');
        INPLANE{1} = computeCorAnal(INPLANE{1},0); INPLANE{1}=refreshScreen(INPLANE{1});

%         if notDefined('VOLUME')
%             VOLUME{1} = open3ViewWindow('gray');
%         end
%         
%         mrAlign3
%         loadAlignment
%         VOLUME{1} = selectDataType(VOLUME{1}, 'Timed');
%         
        % Computer CorAnal all scans
%         INPLANE{1}=computeCorAnal(INPLANE{1},0); INPLANE{1}=refreshScreen(INPLANE{1});
end

end

%% Note: type "doc hungarian" for variable prefix explanation.
