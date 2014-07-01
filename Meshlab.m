function [iStatus, result] = Meshlab(pFile)

% Meshlab;
%
% Wrapper for Meshlab unix program
%
% Khan 01/19/2011

%% Default params


%% Initialize


%% Main
[result, iStatus] = linux('OpenMeshlab', pFile, pwd);

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
