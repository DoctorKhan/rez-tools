function FiguresHRFAll(voHemo, voROIs, voCNRs)
%
%
%
% Khan 08/04/2011

%% Default params
%% Initialize
close all
% voBins = BinBounds(.15,.25);

% ROIs
pFigs = ExportPath('mri', 'LaminarHemo', 'Figures');
if ~exist(pFigs, 'dir'), mkdir(pFigs); end

%% Main
iN = linux('NextFileNum', pFigs);
voFigFiles = dir(pFigs);
csFigFiles = {voFigFiles.name};
HemoInit
for oHemo = voHemo
	cds(oHemo)
	
	for oROI = voROIs
		for oCNR = voCNRs
			oROI.name = [oROI.name, 'u', oCNR.name];
			oROI.filename = ['BootHRFAnalysis-', oROI.name];
			sN = sprintf('%04d', iN);
			oROI.comment = [oROI.comment ' - ' oCNR.comment];
			close all;
			FiguresHRF(oHemo, oROI);
			
			sSuffix = ['-' oHemo.sSession '-' oROI.name];
			
			if CellMatch(csFigFiles, ['.*' sSuffix '.*'])
				[~, csMatches] = CellMatch(csFigFiles, ['.*' sSuffix '.*']);
				sFilename = csMatches{1};
				sPrefix = regexprep(sFilename, '-.*', '');
				iN = linux('NextFileNum', pFigs) - 1;
			else
				sPrefix = ['Fig' sN];
			end
			
			sFigName = [sPrefix '-' oHemo.sSession '-' oROI.name];
			SaveFigure(fullfile(pFigs, sFigName));
			iN = iN + 1;
		end
	end
end

close all
end %function
%% Note: type "doc hungarian" for variable prefix explanation.
