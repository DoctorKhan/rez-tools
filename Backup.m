function Backup(pFile, varargin)

% Backup(pFile);
%
%
%
% Khan 04/24/2012
 
%% Default params


%% Initialize


%% Main
if isFile(pFile)
    pTemp = [pFile, '~'];
    copyfile(pFile, pTemp, 'f');
    if Option('verbose')
        Str('Created backup file', pTemp);
    end
end

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
