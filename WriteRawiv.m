function pRawiv = WriteRawiv(oRawiv, pRawiv, varargin)

% oRawiv = WriteRawiv(pRawiv, varargin);
%
%
%
% Khan 03/15/2012

%% Default params
Default pRawiv = oRawiv.filename;
Destruct(oRawiv);
Default vScale = [1 1 1];

%% Initialize
if isObStruct(pRawiv), pRawiv = pRawiv.filename; end
pRawiv = FileExt(pRawiv, varargin{:}, 'rawiv', 'weakly');

Backup(pRawiv)
% touch(pRawiv);
id = fopen(pRawiv,'w','ieee-be');

%% Main
if ~regmatch(pRawiv, 'tmp')
    Str('Writing', pRawiv, '...');
end
Destruct(oHeader);
Default mystery = int32(-1163018513);

% Write header
fwrite(id, mBox', '*float32');
fwrite(id, nVoxels, '*int32');
fwrite(id, nGridPts, '*int32');
fwrite(id, mBoxMax, '*int16');
fwrite(id, mystery, '*int32');
fwrite(id, vMinMax, 'single');
fwrite(id, vScale, 'float32');

% Data
fwrite(id, tData, 'float32');
fclose(id);

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
