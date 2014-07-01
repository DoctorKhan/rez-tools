function varargout = LamFitTable(voHemo, voROIFiles)

% varargout = LamFitTable(voHemo, voROIFiles);
%
%
%
% Khan 09/20/2011
% Khan 10/24/2011 - Writes output file

HemoInit

%% Default params
Default voROIFiles = FindHemoFiles

%% Arg handling
voROIFiles = FindHemoFiles(voROIFiles);

%% Initialize
pCurrent = pwd;

sHeader = [ 'New, ROI, Bin, Range, Units, # Voxels, FWHM Time Slope, P, Initial Dip Time Slope, P, Initial Dip Value Slope, ' ...
	'P, Peak Time Slope, P, Peak Value Slope, P, Undershoot Time Slope, P, Undershoot Value Slope, P, CNR'];

csText = {};
%% Main
for oHemo = NumStruct(voHemo)
	cds(oHemo)
	
	csText{1, oHemo.iNum} = [ 'Subject: ' oHemo.sSubject];
	csText{2, oHemo.iNum} = sHeader;
	
	for oROI = NumStruct(voROIFiles)
		pFilename = strtrim(oROI.name);
		if ~exist(pFilename, 'file')
			continue
		end
		
		TextWaitbar(oROI, oHemo);
		
		oResults = Load(pFilename);
		
		if isfield(oResults(1).oROI, 'nVoxels')
			sVoxels = num2str(oResults(1).oROI.nVoxels);
		else
			sVoxels = 'NR';
		end
		
		oR = oResults(1);
		if ~isfield(oR, 'voFit')
			oResults = FixFitParams(oROI, oHemo);
		end
		
		vo = oResults(1).voFit;
		
		for o = NumStruct(vo)
			m(1,o.iNum) = o.vFitParams(1); 
			m(2,o.iNum) = o.vP(1); 
		end
				
		s = RoundSig(HorzVec(m), 2, 'string');
		sData = regexprep(s, ' *', ', ');
		
		oROIInfo = DecodeHemoName(oROI);
		Destruct oROIInfo
		
		csText{oROI.iNum + 2, oHemo.iNum} = Str(sLam, sName, sType, sRange, sUnits, ...
			sVoxels, sData, sCNR, {', '});
		%                 RoundSig(vP(iFitOrder, iParam), 2, 'string')
	end
	
	csText{oROI.nTot+3, oHemo.iNum} = ' ';
end

csText = csText(:);

%% Clean up
cd(pCurrent);

if nargout > 0
	varargout{:} = csText;
else
	WriteTextFile('LamFitTable.csv', csText)
	linux gnumeric LamFitTable.csv&
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
