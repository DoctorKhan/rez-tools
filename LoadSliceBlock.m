function [tsSliceBlock, mbFinite] = LoadSliceBlock(oView, sOption, viScans, pFile, varargin)

% [tsSliceBlock, mbFinite] = LoadSliceBlock(oView, pFile, viScans);
%
%
%
% Khan 07/21/2011

%% Default params
Default  pFile="SliceBlock.mat" & viScans & sOption = "load"

%% Initialize
if defined('sOption'), varargin{end+1} = sOption; end
	
%% Main
if notDefined('tsSliceBlock')
	if exist(pFile, 'file') && ~Option('force|dejitter')
	    Str('Loading sliceblock', FullPathname(pFile));
		load(pFile);
	end
	if isempty('tsSliceBlock') || notDefined('mbFinite')
		Default sDataType = "Timed"
		[tsSliceBlock, mbFinite] = GetSliceBlock(oView, viScans, sDataType);
	end
else
	disp('Global SliceBlock present.');
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
