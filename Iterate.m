function xOut = Iterate(xIn, sFunc, viIters)

% xOut = Iterate(xIn, sFunc);
%
%
%
% Khan 01/03/2012
 
%% Initialize
sFunc = regexprep(sFunc, '"', '''');

%% Main
if ~isempty(regexpi(sFunc, '\.iter'))
	if iscell(xIn)
		if isstruct(xIn{1})
			csFieldNames = fieldnames(xIn{1}); 
		else
			csFieldNames = xIn;
		end
	end
	
	for csField = HorzVec(csFieldNames), sField = csField{1};
		sCommand = [regexprep(sFunc, '\.iter', ['.' sField]), ';'];
		xOut.(sField) = evalin('caller', sCommand);
	end
else
	nIters = length(xIn);
	
	iIter = 1; 
	sCommand = [regexprep(sFunc, 'iter', num2str(iIter)), ';'];
	xOut = repmat(evalin('caller', sCommand), 1, nIters);
	
	for iIter = 2:nIters
		sCommand = [regexprep(sFunc, 'iter', num2str(iIter)), ';'];		
		xOut(iIter) = evalin('caller', sCommand);
	end
end

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
