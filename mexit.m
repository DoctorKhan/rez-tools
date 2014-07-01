function mexit(pFile)

% mexit(pFile);
%
%
%
% Khan 02/27/2012
 
%% Default params


%% Initialize
Default pFile = latest('*.cpp');

%% Main
mex('-v', '-f', [matlabroot '/bin/matopts.sh'], pFile);

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
