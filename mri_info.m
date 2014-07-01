function msInfo = mri_info(pFile)

% mri_info;
%
%
%
% Khan 04/26/2012
 
%% Default params


%% Initialize


%% Main
msInfo = linux('surf mri_info', pFile);

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
