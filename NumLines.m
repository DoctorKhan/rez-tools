function nLines = NumLines(pFile)

% n = NumLines(pFile);
%
%
%
% Khan 12/27/2011
% Luther 01/05/2012
 
%% Default params


%% Initialize
fid = fopen(pFile,'rt');
nLines = 0;
while (fgets(fid) ~= -1),
  nLines = nLines+1;
end
fclose(fid);
 
%% Note: type "doc hungarian" for variable prefix explanation.
