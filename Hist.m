function [viCounts, vBinLocs] = Hist(vData, nBins, iFig, varargin)

% varargout = Hist(vData, nBins, iFig, varargin);
%
%
%
% Khan 12/20/2011
 
%% Default params


%% Initialize
Default nBins = 80;
varargout = cell(1,nargout);

%% Main
if nargout == 0
	Default iFig = gcf;
	try
		figure(iFig);
	end
	hist(vData(:), nBins, varargin{:});
else	
	[viCounts, vBinLocs] = hist(vData(:), nBins, varargin{:});
end

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
