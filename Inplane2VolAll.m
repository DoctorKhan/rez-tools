function Inplane2VolAll(voHemo)

%
% Inplane2VolAll(voHemo);
%
%
%
% Khan 07/13/2011

%% Default params
HemoInit

%% Initialize
mrGlobals

%% Main
for oHemo = voHemo
    close all;
    
    cds(oHemo);
    oInp = initHiddenInplane;
    oInp = loadAnat(oInp);
    
	% Remove all datatypes after "Timed."
    while ~strcmp(dataTYPES(end).name, 'Timed')
        removeDataType(dataTYPES(end).name, 0);
    end
    
    selectScans(oInp, '', '', 'all');
    
    % Timed
    oInp = selectDataType(oInp, 'Timed');
    
    oInp = computeMeanMap(oInp, 0, 1);
    oInp = computeSpatialGradient(oInp);
    
    % Create gray view and transform Timed & Averages data to volume:
    oGray = initHiddenGray;
    oGray = loadAnat(oGray);
	oGray = GrayCoords(oGray);
    
    % Transform timed into volume
    oGray = selectDataType(oGray, 'Timed');
    oInp  = selectDataType(oInp, 'Timed');
    
	% Load spatial gradient map
    oInp = loadParameterMap(oInp, 'spatialGrad.mat');
    
	% Transform tSeries into gray
    oGray = ip2volTSeries(oInp, oGray, 0, 'linear');
    oGray = ip2volParMap(oInp, oGray, 0, 1, 'nearest');
    
    oInp  = selectDataType(oInp, 'Averages');
    oGray = selectDataType(oGray, 'Averages');
    
    oInp = loadParameterMap(oInp, 'spatialGrad.mat');
    
	% Avoids interpolation errors
    oGray = ip2volParMap(oInp, oGray, 0, 1, 'nearest');
    
    %% Load mesh
    oHemo.pWhiteMesh = AnatPath(GetSubject, 'Cortex', '3DMeshes', 'BothFullRefined.mat');
    pWhiteMesh = oHemo.pWhiteMesh;
    
    if exist(pWhiteMesh, 'file')
        oGray = meshLoad(oGray, pWhiteMesh);
        msh = readMesh(pWhiteMesh);
    else
        error('No mesh.');
    end
    
    %% Map Laminar Indices
    % This builds the laminar coordinates for MarkLaminarROI, which extends the
    % ROI.
    
    % [sLeftpath, sRightpath] = GetAnatomyPaths(oHemo.sSubject, sRegion); % Left and right .Gray file pathnames.
    % oVol.leftPath = sLeftpath; oVol.rightPath = sRightpath;
    MapLaminarIndices([-3,3], 1.5, msh, 0, 0, oGray); % Cortex: Extension 3mm, avg radius: 1.5 mm
    
end

end %function
%% Note: type "doc hungarian" for variable prefix explanation.
