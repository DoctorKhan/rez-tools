function [csFile, sFile] = ReadNumAscii(sPathname, nLines, sDelim)

% [csFile, sFile] = ReadNumAscii(sPathname, nLines);
%
%
%
% Khan 02/17/2010
% Khan 12/27/2011 - added nLines

%% Default params
Default nLines = NumLines(sPathname);
Default sDelim = " ";

%% Initialize
csFile = cell(1, nLines);

%% Main
fid = fopen(sPathname);

nLines = str2double(fgets(fid));

vLine = HorzVec(str2double(regexp(fgets(fid), sDelim, 'split')));
mData = repmat(vLine, nLines, 1);

% Read m-file into cell structure
for iLine = 2:nLines
	sLine = fgets(fid);
	
	if ischar(sLine)
		mData(iLine,:) = str2double(regexp(sLine, sDelim, 'split'));
	else
		break
	end
end

fclose(fid);

%% Output
sFile = [csFile{:};];

end %function

%% Note: type "doc hungarian" for variable prefix explanation.
