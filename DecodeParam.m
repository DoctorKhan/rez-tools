function csParams = DecodeParam(csParams)

% csParams = DecodeParam(csParams);
%
%
%
% Khan 01/09/2012
 
%% Default params


%% Initialize

%% Main
csParams = regexprep(csParams, '^PeakValue$', 'PeakAmplitude');
csParams = regexprep(csParams, '^PeakTime$', 'TimeToPeak');
csParams = regexprep(csParams, '^FWHMValue$', 'FWHMInterval');

if iscell(csParams)
	csParams = CellFun(@SplitByCase, csParams);
else
	csParams = SplitByCase(csParams);
end

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
