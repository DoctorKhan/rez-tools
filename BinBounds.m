function [ voBins viBins] = BinBounds(dx, binWidth, vBounds, sName, varargin)

% [ voBins viBins] = BinBounds(dx, binWidth, vBounds, varargin);
%
%
%
% Khan 07/21/2011

%% Default params
if notDefined('vBounds'), vBounds = [-1 2]; end
if notDefined('dx'), dx = .2; end
if notDefined('binWidth'), binWidth = dx;end
Default sName
%% Initialize

%% Main
if isLongVector(dx)
	vBinDepths = dx;
else
	lowerBound = vBounds(1);
	lowerBound = lowerBound + binWidth/2;
	
	upperBound = vBounds(2);
	upperBound = upperBound - binWidth/2;
	
	if CellMatch(varargin, 'lower')
		vBinDepths = lowerBound:dx:upperBound;
	else
		vBinDepths = flipdim(upperBound:-dx:lowerBound,2);
	end
end

vLower = vBinDepths - binWidth/2;
vUpper = vBinDepths + binWidth/2;
nBins = length(vBinDepths);

for ii = 1:nBins
	voBins(ii) = struct('lower', vLower(ii), 'upper', vUpper(ii), ...
		'middle', vBinDepths(ii), 'iBin', ii, 'name', sName);
end

% voBins = voBins);
viBins = 1:nBins;

voBins = NumStruct(voBins);

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
