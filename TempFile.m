function pTempFile = TempFile(varargin)

% pTempFile = TempFile(varargin);
%
%
%
% Khan 12/30/2011
 
%% Default params


%% Initialize
pFileIn = St(varargin{:});
pTemp = tempname;
pTempFile = [pTemp, StripPath(pFileIn)];

%% Main
if isFile(pFileIn)
%     mkdir(pTemp);
    copyfile(pFileIn, pTempFile);
else
    Touch(pTempFile);
end

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
