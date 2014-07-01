% FsFast;
%
% Freesurfer fast.
%
% Khan 05/15/2012
 
%% Main
if ~isempty(getenv('FREESURFER_HOME'))
    pFreeMat = fullfile(getenv('FREESURFER_HOME'), 'matlab');
    pFreeBox = fullfile(getenv('FSFAST_HOME'), 'toolbox');
    if exist(pFreeMat, 'dir'), addpath(pFreeMat); end
    if exist(pFreeBox, 'dir'), addpath(pFreeBox); end
    
    clear pFreeMat pFreeBox
end

%% Note: type "doc hungarian" for variable prefix explanation.
