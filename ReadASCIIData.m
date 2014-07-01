function tData = ReadASCIIData(pFile, viDim, nHeaderLines)

% tData = ReadASCIIData(pFile, viDim, nHeaderLines);
%
%
%
% Khan 02/18/2012
 
%% Default params


%% Initialize
pOut = FileExt(pFile, '.mat');
Default nHeaderLines = 0;

%% Main
linux('dmp2mat', pFile, pOut);
load(pOut);

if notDefined('viDim')
    nDataIn = length(data)-nHeaderLines;
    viDim = [nDataIn, 1];
end

nDataOut = prod(viDim);
viDataOut = (1:nDataOut) + nHeaderLines;
tData = reshape(data(viDataOut), viDim);

rm(pOut);
end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
