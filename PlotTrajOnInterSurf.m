function oView = PlotTrajOnInterSurf(oView, viSurf, sliceWidth, varargin)

% PlotTrajOnInterSurf;
%
%
%
% Khan 02/18/2012
 
%% Default params
Default viSurf = 8;
Default sliceWidth = 0.5;
%% Initialize
pDir = fullfile(fileparts(DefaultAnatomyPath), 'Left', '3DMeshes', 'White-Pia');
%ReadDumpIntoVolume('DumpWhite.raw');

iSlice = getCurSlice(oView);
iDim = getCurSliceOri(oView);
% hold on
%% Main
for iSurf = viSurf
    pFile = fullfile(pDir, ['InterThick', num2str(iSurf), '.pcd']);
    pMat = FileExt(pFile, '.mat');
    linux('raw2mat', pFile, pMat);
    load(pMat);
    tData = reshape(data(1:header), 4, []);
    tCoords = squeeze(tData(1:3,:));
    PlotSliceInVista(oView, tCoords, iSlice, iDim, sliceWidth);
end
   


%% Main

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
