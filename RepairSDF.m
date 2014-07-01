function tSDFFixed = RepairSDF(pFile, pOut, sdfLimit, varargin)

% tSDFFixed = RepairSDF(pFile, sdfLimit);
%
% It should correct regions less than sdf = sdfLimit.
%
% Khan 02/21/2012
 
%% Default params
Default pOut = pFile;
Default sdfLimit = 2;

%% Initialize


%% Main
disp('Reading SDF...');
tSDF = ReadDumpIntoVolume(pFile);
tbFix = tSDF < sdfLimit;

disp('Computing Laplace solution...');
tSDFFixed = LaplaceMultiplier(tSDF, tbFix);

disp('Writing output.');
WriteRawiv(tSDFFixed, pOut, '', varargin{:})
end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
