function mTSeries = JitterCorrect1(mTSeries, vJitterData, framePeriod)

% mTSeries = JitterCorrect1(mTSeries, vJitterData);
%
%
%
% Khan 07/22/2011

mrGlobals
StdGlobals

%% Default params
%e.g. 1.5 s between samples
Default framePeriod = mrSESSION.functionals(1).framePeriod

%% Initialize
nVoxels = size(mTSeries, 2);
nWaitUpd = round(nVoxels/20);
sMessage = 'Jitter Correction';
%% Main

TimedWaitbar(0, sMessage); 
    for iVoxel = 1:nVoxels
        mTSeries(:,iVoxel) = JitterCorrection(mTSeries(:,iVoxel), framePeriod, vJitterData);
        if max(mTSeries(:)) > 50, keyboard; end
        if mod(iVoxel, nWaitUpd) == 0
            max(mTSeries(:))
            TimedWaitbar(iVoxel/nVoxels);
        end
    end
end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
