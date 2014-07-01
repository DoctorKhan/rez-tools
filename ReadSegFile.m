function [oSeg, oRibbon] = ReadSegFile(sFile, sOption)

% [oSeg, oRibbon] = ReadSegFile(sFile, sOption);
%
%
%
% Khan 06/28/2011

%% Default params
if notDefined('sFile');
    sFile = linux('latest *Seg.nii.gz');
end

if notDefined('sOption'), sOption = ''; end

%% Argument handling
sFile = strtrim(sFile);

%% Main
% Read data and transform if requested
oRibbon = ConvertTransform(sFile, sOption);

% Define colors
lh.type.unknown = 0;
lh.type.white = 2; 
lh.type.gray = 3; 
rh.type.unknown = 0;
rh.type.white = 41; 
rh.type.gray = 42; 

% Extract white volume from Freesurfer seg
lh.white = (oRibbon.data == lh.type.white);
rh.white = (oRibbon.data == rh.type.white);
lh.gray  = (oRibbon.data == lh.type.gray);
rh.gray  = (oRibbon.data == rh.type.gray);
lh.unknown = (oRibbon.data == lh.type.unknown);
rh.unknown = lh.unknown;

oSeg.lh = lh;
oSeg.rh = rh;

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
