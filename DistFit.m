function DistFit

% DistFit;
%
%
%
% Khan 11/22/2011

%% Default params


%% Initialize


%% Main
[oLoad, pFile] = Load(oFile);
	
	if isLongVector(oLoad)
		oLoad = oLoad(iPolyFit);
	end
	
	Destruct oLoad -> omBootParams oParams voHrfs oMeanHRFs voFit oROI
	voBins = oROI.voBins;
	
	mBootUndershoot = omBootParams.UndershootTime;
	close all; vFRange = [.4 .8];
	vFrac = normalize(1:size(mBootUndershoot,2));
	viFrac = vFrac > vFRange(1) & vFrac < vFRange(2); figure
	vData = restrict(mBootUndershoot(:,viFrac), 1, 28, 'remove');

	histfit(vData,40);
	[mu,sigma,muci,sigmaci] = normfit(vData);
	hist(restrict(mBootUndershoot(:,viFrac), 19, 28, 'remove'),40);
end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
