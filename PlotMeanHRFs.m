function PlotMeanHRFs(oROI, cnr, viSelectedBins)

% PlotMeanHRFs;
%
%
%
% Khan 07/29/2011

%% Default params


%% Initialize
hFig = oROI.number;
disp(num2str(hFig))
sCnr = num2str(cnr);
sROIName = oROI.name;

sROITitle = regexprep(regexprep(sROIName, 'Lp', ' Left Hemisphere'), 'Rp', ' Right Hemisphere');
sTitle = [ sROITitle, ' - Upper ' sCnr, ' percent of CNR rated voxels'];
pFile =  ['BootHRFAnalysis-', sROIName, 'u', sCnr ];

%% Main

% Load results
oAnal = Load(pFile);

if isempty(oAnal)
	returnls
end

voHRFs = oAnal.oHRFs;
voBins = oAnal.roi.bins(viSelectedBins);

vX = voHRFs(1).vXi;
mY = cell2mat({voHRFs.vYi}');

yMin = min([mY(:); yMin]);
yMax = max([mY(:); yMax]);

% Plot
figure(hFig); plot(vX, mY(viSelectedBins, :), 'linewidth', 2);
xlabel('Time (s)');
ylabel('Percent Modulation');
title(sTitle);
legend(csLegend{:}, 'Location', 'best');

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
