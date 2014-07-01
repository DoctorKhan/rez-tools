% mrVistaClose;
%
%
%
% Khan 07/18/2011

%% Default params
mrGlobals

%% Initialize


%% Main
clear mrSESSION VOLUME INPLANE dataTYPES

figs = get(0,'Children');
try
set(figs,'mrVistaCloseFcn','closereq');
catch
    close all
end
%% Note: type "doc hungarian" for variable prefix explanation.
