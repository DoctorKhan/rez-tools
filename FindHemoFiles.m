function [voOut, csFiles] = FindHemoFiles(xFilter, voHemo, varargin)

% [voOut, csFiles] = FindHemoFiles(viSubset);
%
%
%
% Khan 10/19/2011

try
	%% Default params
	if isnumeric(xFilter)
		viSubset = varargin{1};
	end
	
	if isNumStr(xFilter)
		viSubset = str2int(xFilter);
	end
	
	if ischar(xFilter)
		sSubset = xFilter;
	end
	
catch
end

%% Default
Default sSubset = "BootHRFAnalysis*-*.mat"
%% Initialize
HemoInit
pCurrent = pwd; 

%% Main
% Collect intersection of roi files amongst subjects
for oHemo = NumStruct(voHemo, 'backup')
	cds(oHemo)
	csDirFiles = Ls(sSubset, 'name');
	Default csFiles = csDirFiles
	csFiles = intersect(csFiles, csDirFiles);
end

voOut = Str2Struct(csFiles);

if defined('viSubset')
	if ischar(viSubset)
		voOut = eval(['voOut(' viSubset ');']);
	else
		voOut = voOut(viSubset);
	end
end

cds(pCurrent);
end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
