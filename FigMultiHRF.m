function FigMultiHRF(xROI, varargin)

% FigMultiHRF;
%
%
%
% Khan 11/22/2011

%% Default params


%% Initialize


%% Main
cxROIs = HorzVec(sort(xROI)); 
for cxROI = cxROIs
	if iscell(cxROI), xROI = cxROI{1}; end
	figure;
		FiguresHRF(xROI, varargin{:});
		
end


end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
