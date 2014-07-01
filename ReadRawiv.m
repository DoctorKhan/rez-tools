function [oRawiv, vData] = ReadRawiv(pFile, varargin)

% [oRawiv, vData] = ReadRawiv(pFile, varargin);
%
%
%
% Khan 02/28/2012

%% Default params
Default filename | tData | tFull | mBox | vScale | viDim;

%% Initialize
if isRawiv(pFile)
    oRawiv = pFile;
    pFile = oRawiv.filename;
else
    pFile = FileExt(pFile, varargin{:}, 'rawiv', 'weakly');
end

%% Main
if Option('adjust')
    Destruct oRawiv
else
    voFiles = dir(pFile);
    if isempty(voFiles)
        error(Str('Could not find', pFile));
    end
    
    pFile = fullfile(fileparts(pFile), voFiles(1).name);
    nData = voFiles(1).bytes/4-17;
    
    if ~regmatch(pFile, 'tmp')
        Str('Reading volume:', pFile, '.');
    end
    
    %%
    f = fopen(pFile,'r','ieee-be');
    
    % Header
    % 1- 6
    mBox = double(fread(f, 6, '*float32'));
    mBox = reshape(mBox,3,2)';
    
    % 7 - 8
    oHeader.nVoxels = double(fread(f, 1, '*int32')); % 300^3
    oHeader.nGridPts = double(fread(f, 1, '*int32')); % 299^3
    
    % 9 - 11
    oHeader.miBox = reshape(fread(f, 6, '*int16'), 2, []); % [0 300 0 300 0 300];
    miBox = double(oHeader.miBox);
    viDim = miBox(2,:);
    
    % 12 = strange constant = -1163018513
    oHeader.mystery = fread(f, 1, '*int32');
    
    % 13-14
    oHeader.vMinMax = fread(f, 2, '*single');
    
    % 15-17
    vScale = double(fread(f, 3, '*float32'))';
    
    %%
    mBox(1,:) = mBox(2,:) - (viDim-1).*vScale;
    
    try
        assert(isequal(round(diff(mBox)./vScale)+1,viDim), 'Dim mismatch.');
    catch
        keyboard
    end
    
    % Data
    if prod(viDim) ~= nData
        Ste('Dimensional mismatch', viDim, 'has', prod(viDim), 'elements. Not', nData, 'in file.');
    end
end

nData = prod(viDim);
vData = double(fread(f, nData, '*float32'));
fclose(f);
tData = reshape(vData, viDim);

filename = pFile;
tFull = [];
oRawiv = Struct(filename, tData, tFull, oHeader, vScale, mBox, viDim);
oRawiv = Rawiv(oRawiv);

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
