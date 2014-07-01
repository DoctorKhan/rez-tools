function SetupStartupFinishFiles

% SetupStartupFile;
% 
% 
% 
% Khan 02/17/2010

%% Default params


%% Initialize


%% Main
[sStartupPath, fn, ext] = fileparts(which('startup'));
sStartupPn = fullfile(sStartupPath, [fn, ext]);

[csText, sText] = ReadTextFile(sStartupPn);

if isempty(regexpi(sText, 'LoadLastProject'))   
    csText{end+1} = '';
    csText{end+1} = '%% Load the previously active project into memory';
    csText{end+1} = 'LoadLastProject;';
    WriteTextFile(sStartupPn, csText);
end

% Finish file
sFinishPn = fullfile(sStartupPath, 'finish.m');

csSave = { '%% Save Project', 'SaveProject' };

if exist(sFinishPn, 'file')
    
    [csFinish, sFinish] = ReadTextFile(sFinishPn);
    
    if isempty(regexpi(sFinish, '%% Save Project'))
        csFinish = {csFinish{:}, csSave{:}};
        WriteTextFile(sFinishPn, csFinish);
    end
else
        WriteTextFile(sFinishPn, csSave);    
end

end %function
