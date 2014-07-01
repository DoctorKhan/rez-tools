function oView = InitHidden(sViewType, sDataType, varargin)

% oView = InitHidden(sViewType, sDataType, varargin);
%
%
%
% Khan 07/24/2011

mrGlobals
%% Default params
Default sViewType = "Gray" & sViewName = "oDefView"
iScan = str2int(varargin);
Default sDataType="Timed" & iScan=1
[bView, ~, ~, oViewIn] = Option(@isView);

%% Initialize
linux date >> lam.log
% [bDejitter, sDejitter, varargin] = Option('Dejitter');
% [bNorm, sNorm, varargin] = Option('Norm');

%% Main
switch TitleCase(sViewType)
	case 'Volume'
		oView = initHiddenVolume(sDataType, iScan);
	case 'Gray'
		oView = initHiddenGray(sDataType, iScan);
end

% Load Spatial Gradient for Inhomogeneity Correction
oView = loadSpatialGradient(oView);
oView.session = SessionFromDir;

%% Main
if Option('SliceBlock') || bView 
	if isField(oViewIn, 'session', oView.session)
		disp(['Using existing sliceblock for ' oView.session '.'])
		oView.tsSliceBlock = oViewIn.tsSliceBlock;
	elseif exist(SessionDir('SliceBlock.mat'), 'file')
		oView.tsSliceBlock = LoadSliceBlock(oView);
		oView.session = SessionFromDir;
	else
		disp('Could not load sliceblock. Creating...');
		varargin{Option('SliceBlock')} = 'Dejitter';
	end
end

if Option('Dejitter')
	% Load slice block with jitter correction
	oView.tsSliceBlock = LoadSliceBlock(oView, 'dejitter');
	oView.session = SessionFromDir;
end

% Load normalized distance map
if Option('Anat'), oView = loadAnat(oView); end
if Option('Norm'), oView = LoadNormDepthMap(oView); end

% NormalizedDepthMap(oView, '', 'Compute');

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
