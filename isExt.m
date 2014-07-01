function bOut = isExt(sExt, pFilename)

% bOut = isExt(sExt, pFilename);
%
% Check if sExt belongs to pFilename. By itself, checks if sExt is an
% extension.
%
% Khan 12/27/2011
 
%% Default params


%% Initialize


%% Main
if defined('pFilename')
    bOut = strcmp(pFilename, FileExt(pFilename, sExt));
else
    bOut = ~isempty(regexp(sExt, '\.[^. \t][^. \t]*$', 'once'));
end

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
