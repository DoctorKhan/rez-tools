function CollectHemoMaps

% CollectHemoMaps;
%
%
%
% Khan 10/13/2011

%% Default params
% Default oView = InitHidden('Volume')


%% Initialize
vNorm  = [];
	vCurve = [];
	vThick = [];
	vPhys  = [];
pCur = pwd;

%% Main
for oHemo = voHemo
	ii = oHemo.iNum;
	cds(oHemo)
	
	Default oView = InitHidden('Volume')
	
	[~, oMaps] = NormalizedDepthMap(oView);
	
	Destruct oMaps
% 	cvNorm{ii}  = vNormMap(vbFinite);
% 	cvCurve{ii} = vCurvMap(vbFinite);
	cvThick{ii} = vThickMap(vbFinite);
% 	cvPhys{ii}  = vPhysMap(vbFinite);
	
	vNorm  = [vNorm  vNormMap(vbFinite)];
	vCurve = [vCurve vCurvMap(vbFinite)];
	vThick = [vThick vThickMap(vbFinite)];
	vPhys  = [vPhys  vPhysMap(vbFinite)];
	
	TextWaitbar(oHemo, oHemo);
	clear global oView
end
cd(pCur);

oCombDist = Struct(vNorm, vCurve, vThick, vPhys);
histfit(vThick,50);

cvThickBounds = CellFun(@CalcConfidenceIntervals, cvThick);
[a iMin] = min(diff(cell2mat(cvThickBounds')'));

oBounds.vThick = cvThickBounds{iMin};
oBounds.vCurve = CalcConfidenceIntervals(vCurve);

for oHemo = voHemo4
	Save(StructDir(oHemo, 'CombinedMaps'), oCombDist, oBounds);
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
