function CombineHemoROIs(sSession)

% CombineHemoROIs;
%
% Combine left and right hemisphere ROIs as well as larger unions and save
% locally.
%
% Khan 08/04/2011

%% Default params
Default sSession = SessionFromDir

%% Initialize
clear global
HemoInit
cds(sSession);
oHemo = HemoFromDir;

o.pLocal = fullfile('Gray', 'ROIs');
o.pShared = AnatPath(oHemo, '', 'ROIs');
Default oView = initHiddenGray;

%% Main
os.D = 1; os.V = 2;

for iPrim = 1:3
	for sLoc = 'DV'
			sROI = ['V' num2str(iPrim) sLoc 'p.mat'];
			oComb = CombineLR(sROI, o);
			oRestricted = RestrictROI2Layer1(oComb, oView);
			SaveROI(oRestricted, o);
			coROIs{iPrim, os.(sLoc)} = oRestricted;
	end
	
	oV(iPrim) = ROIUnion(coROIs{iPrim, :});
% 	oV(iPrim).name = regexprep(oV(iPrim).name, 'p', 'dv');
	SaveROI(oV(iPrim), o);
end

for sLoc = 'DV'
	SaveROI(ROIUnion(coROIs{:, os.(sLoc)}), o);
end

% Make total ROI
V3Ap = CombineLR('V3Ap.mat', o);
oAll = ROIUnion(coROIs{:, os.(sLoc)}, V3Ap);
oAll.name = 'V123p';
SaveROI(oAll, o);

% Make extratriate
oExtraStriate = ROIUnion(oV(2), oV(3), 'V23p');
SaveROI(oExtraStriate, o);

end

function oROI = ROIUnion(varargin)
	if ischar(varargin{end})
		sName = varargin{end};
		varargin(end) = [];
	end
	
	voROIs = cell2mat(varargin);
	oROI.coords = UnionCols(voROIs.coords);
	
	if defined('sName')
		oROI.name = sName;
	else
		oROI.name = StringIntersect(voROIs.name);
	end
end

function ROI = CombineLR(sROI, o)
	os.L = 1; os.R = 2;
	
	for sHem = 'LR';
		sFilename  = regexprep(sROI, 'p', [sHem, 'p']);
		pFilename  = fullfile(o.pShared, sFilename);
		cm{os.(sHem)} = Load(pFilename);
	end
	
	% Make ROI
	ROI = ROIUnion(cm{:});
	
	if ~isfield(ROI, 'roiSize'), ROI.roiSize = []; end	
end

function SaveROI(ROI, o)
	ROI.local='local';
	disp(fullfile(o.pLocal, ROI.name));
	Save(fullfile(o.pLocal, ROI.name), ROI);
end

%% Note: type "doc hungarian" for variable prefix explanation.