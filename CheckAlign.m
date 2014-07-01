function CheckAlign(voHemo, varargin)

% CheckAlign;
%
%
%
% Khan 12/29/2011

%% Initialize
if Option('All')
	csHemis = {'Left', 'Right', 'Both'};
else
	csHemis = varargin;
end

%% Default params
Default csHemis = {'Left'};
HemoInit

%% Main
for oHemo = voHemo
	cds(oHemo);
	Destruct oHemo;
	
	for csHemi = csHemis, sHemi = csHemi{1};
		[oWhite, oPia] = GetMesh(sSubject, sRegion, sHemi);
% 		if strcmpi(sHemi, 'Both')
		pDom = AnatPath(sSubject, sRegion, sHemi, '3DMeshes', 'White-Pia', 'White-Pia.mat');
		tbDomain = Load(pDom);
		oPia = Load(AnatPath(sSubject, sRegion, sHemi, '3DMeshes', 'Pia.mat'));
		viDim = size(tbDomain);
		
		% a = RandSample(1:size(ctCoords{2},2), [1 1000]);
		% f = ctCoords{2}(:,a,1);
		% l = ctCoords{2}(:,a,end);
		% tF = sub2log3d(f, viDim);
		% tL = sub2log3d(l, viDim);
		mPia = MatrixVectorDiv(oPia.vertices, oPia.mmPerVox);
		mWhite = oWhite.vertices./oWhite.mmPerVox;
		tP = sub2log3d(mPia, viDim);
		tW = sub2log3d(mWhite, viDim);
		tbCombined = tbDomain + 3*tP;
		cent(tbCombined, 1, 170);
		xlabel(oHemo.name);
		ylabel(sHemi);
		
		vVoi = GetClass(sSubject, sRegion, sHemi, 'header', 'voi');
		
		[reshape(vVoi, 2, []); ...
		size(GetClass(sSubject, sRegion, sHemi, 'data')); ...
		GetDimFromAnat]
	end
end
end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
