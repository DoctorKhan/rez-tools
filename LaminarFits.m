function voFit = LaminarFits(omBootParams, voBins, vBounds, nOrder, nGoodPtsReq)

% oFit = LaminarFits(omBootParams, vBinDepths, vBounds, nOrder, vbFinBin);
%
% Fit gray matter params as a function of depth with a line
%
% Khan 08/08/2011

%% Default params
Default vBounds = [0 1] & nOrder = 1
% num of finite depth values required for each bootstrap fit that is kept
Default nGoodPtsReq = 4

if defined('omBootParams') && ischar(omBootParams)
	pFile = omBootParams;
	omBootParams = Load(pFile, 'omBootParams');
end

if notDefined('voBins')
	Default pFile = uigetfile('BootHRFAnalysis-*.mat');
	oROI = Load(pFile, 'oROI');
	voBins = oROI.voBins;
end

if notDefined('omBootParams')
	Default pFile = uigetfile('BootHRFAnalysis-*.mat')
	Default omBootParams = Load(pFile, 'omBootParams');
end

%% Initialize
disp('Fitting data...')
% param x bootstrap x bin
cmBootDepth = Struct2Cell(omBootParams);

nParams = length(cmBootDepth);
nBoots = size(cmBootDepth{1}, 1);
nBins  = size(cmBootDepth{1}, 2);

% viDim = size(tBootParams);

vBinDepths = [voBins.middle];
nFitParams = nOrder + 1;

tFitParams = nan(nBoots, nParams, nFitParams);
mbFinBin = false(nBoots, 2);
cX = cell(nParams);
%% Main
vbFitRegion = vBinDepths >= vBounds(1) & vBinDepths <= vBounds(2);
% mX = nan(nParams, nBins);
vXf = vBinDepths(vbFitRegion);
pMin = 1/nBoots;
for iParam = 1:nParams
	mFitParams = nan(nBoots, nFitParams);
	mBootDepth = cmBootDepth{iParam}; % This is the parameter to be analyzed
% 	mX(iParam,vbFitRegion) = vXf; % For debug
	mBootParamsFit = squeeze(mBootDepth(:, vbFitRegion));
	
	nTot = total(vbFitRegion);
	
	vbGoodFitBoot = sum(isfinite(mBootParamsFit),2) > nGoodPtsReq;
	mbFinBin = repmat(VertVec(vbGoodFitBoot), [1 nTot]);%	false(size(mBootParamsFit));
	viBoot = HorzVec(find(vbGoodFitBoot));
	for iBoot =  viBoot %1:nBoots
		vY = mBootParamsFit(iBoot,:);
		
		vbFinPts = isfinite(vY);
% 		nFin = total(isfinite(vY));
% 		mbFinBin(iBoot,:) = [ nFin nTot ];
		
% 		if nFin > nGoodPtsReq
			% Fit data 
			mFitParams(iBoot, :) = polyfit(vXf(vbFinPts), vY(vbFinPts), nOrder);
% 		end
	end

	% Find fit params
	vFitParams = nanmean(mFitParams);
	vYf = polyval(vFitParams, vXf);

	% Find p-value	
% 	mFitParamsFin = reshape(mFitParams(isfinite(mFitParams)), [], size(mFitParams, 2));

	vP = nan(1, nFitParams);
	for iFitOrd = 1:nFitParams
		vFitParam1Ord = mFitParams(:,iFitOrd);
		vFitParam1Ord = vFitParam1Ord(isfinite(vFitParam1Ord));
		vP(1,iFitOrd) = fraction(vFitParam1Ord > 0);
	end

	vbPos = vFitParams > 0;
	vP(vbPos) = 1 - vP(vbPos);
  vP(vP<pMin) = pMin;
	
	voFit(iParam) = Struct(vXf, vYf, vP, vFitParams, mbFinBin);
end

voFit = HorzVec(voFit);

%% Output
% mFitParams = squeeze(nanmean(tFitParams));
% oFit = Struct(mP, mFitParams, vBinDepths, vbFitRegion, mX, mbFinBin);
disp('Done fitting.')

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
