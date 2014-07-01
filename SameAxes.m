function SameAxes(mhAxes)

% SameAxes(mhAxes);
%
%
%
% Khan 11/19/2011

%% Default params


%% Initialize

[nFigs, nPlots] = size(mhAxes);
mAxes = zeros(nFigs, 4);

%% Main
if nFigs > 1
	for jj = 1:nPlots
		for ii = 1:nFigs
			mAxes(ii,:) = axis(mhAxes(ii,jj));
		end
		
		vMin = min(mAxes); vMax = max(mAxes);
		vAxis = [vMin(1) vMax(2) vMin(3) vMax(4)];
		
		for ii = 1:nFigs
			axis(mhAxes(ii,jj), vAxis);
		end
	end
end
end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
