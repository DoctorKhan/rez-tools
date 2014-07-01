function pPath = VAnatPath(oHemo)

% pPath = VAnatPath(oHemo, sRegion, sHemi);
%
% Same as getVAnatomyPath, except runs in quiet mode.
%
% Khan 11/18/2011

%% Initialize
Default oHemo = GetHemo;

%% Main
pPath = AnatPath(oHemo, 'vAnatomy.dat');

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
