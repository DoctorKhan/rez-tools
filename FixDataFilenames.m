function FixDataFilenames

% FixDataFilenames;
%
%
%
% Khan 09/27/2011

%% Default params


%% Initialize
HemoInit
csDirs = {'Volume', 'Gray'};

%% Main
for oHemo = voHemo
	cds(oHemo)
	for oFile = HorzVec(dir('BootHRF*.mat'))
		voData = Load(oFile);
		for iData = 1:length(voData)
			viM = voData(iData).oROI.name == 'M';
			voData(iData).oROI.name(viM) = [];
		end
		Save(oFile, voData);
		
		sBadName = oFile.name;
		sGoodName = regexprep(sBadName, 'M', '');
		mv('-v', quote(sBadName), quote(sGoodName));
	end
	
	
	for csDir = csDirs
		cd(fullfile(csDir{1}, 'ROIs'));
		rm ./[0-9]*
		rm ./-*
		for oFile = HorzVec(dir('*.mat'))
			ROI = Load(oFile);
			if ~isstruct(ROI)
				rm(oFile)
				continue
			end
			ROI.name = regexprep(ROI.name, 'Map', '');
			ROI.name(ROI.name == 'M') = [];
			
			Save(oFile, ROI);
			sBadName = oFile.name;
			sGoodName = FileExtension(ROI.name, '.mat');
			mv('-v', quote(sBadName), quote(sGoodName))
		end
		GotoDataDir
	end
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
