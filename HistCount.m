function vHist = HistCount(vData,vEdges)

% HistCount;
%
%
%
% Khan 01/24/2012
 
%% Default params
if length(vEdges) == 1
	vHist = length(vData);
	return
end

%% Initialize
nBins = length(vEdges)-1;
vHist = zeros(1,nBins);
%% Main
for ii = 1:(nBins-1)
	vHist(ii) = sum(vData >= vEdges(ii) & vData < vEdges(ii+1));
end

vHist(nBins) = sum(vData >= vEdges(nBins) & vData <= vEdges(nBins+1));

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
