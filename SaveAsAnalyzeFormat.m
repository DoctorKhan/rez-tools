function SaveAsAnalyzeFormat(Volume, res, sOutputFilename)

%%
if ~exist('sOutputFilename', 'var')
    [fileName, path] = uiputfile('*.*', 'Specify Analyze file name');
    if ~fileName(1), return, end
else
    [path, name, ext] = fileparts(sOutputFilename);
    fileName = [name, ext];
end

%% Modify the matrix to make it appropriate for the saveAnalyze function
volAnal = flipdim(Volume, 1);
volAnal = permute(volAnal, [3 1 2]);
res = res([3 1 2]);
volAnal = int16(round(volAnal/max(volAnal(:)) * 30000));
[pp, name, ex] = fileparts(fileName);
fileName = fullfile(path, name);

analyzeWrite(volAnal, fileName, res);

end