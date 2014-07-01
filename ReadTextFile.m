function [csFile, sFile] = ReadTextFile(sPathname, viLines)

% [csFile, sFile] = ReadTextFile(sPathname, nLines);
%
%
%
% Khan 02/17/2010
% Khan 12/27/2011 - added nLines

%% Default params
nLines = NumLines(sPathname);
Default viLines = 1:nLines;

%% Initialize
vbNeg = viLines < 0;
viLines(vbNeg) = viLines(vbNeg) + nLines + 1;
iMax = max(viLines(:));
csFile = cell(1,iMax);
%% Main

fid = fopen(sPathname);

% Read m-file into cell structure
for iLine = 1:iMax
	sLine = fgets(fid);
	if ischar(sLine)
		csFile{iLine} = sLine;
	else
		break
	end
end
fclose(fid);

csFile = csFile(viLines);
%% Output
sFile = [csFile{:};];

end %function

%% Note: type "doc hungarian" for variable prefix explanation.
