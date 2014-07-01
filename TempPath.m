function sPath = TempPath

% sPath = TempPath;
%
%
%
% Khan 07/06/2011

%% Default params


%% Initialize


%% Main
if ispc
    if exist('c:\temp', 'dir')
        sPath = 'c:\temp';
    else
        sPath = 'c:\windows\temp';
    end
else
    sPath = '/tmp';
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
