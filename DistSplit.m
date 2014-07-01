function [vDist, thresh, sThresh, sThresh2] = DistSplit(vDist, sType, fraction)

% DistSplit(sType, fraction);
%
% Split a distribution by percentage (fraction) critera
%
% Khan 04/21/2010

%% Initialize
vDist = vDist(isfinite(vDist));
nVoxels = numel(vDist);

%% Main
switch nVoxels
	case 0
		thresh = NaN;
	case 1
		thresh = vDist;
	otherwise
		vDistSorted = sort(vDist);
		
		if strcmpi(sType, 'upper')
			iX = normalize(1:nVoxels);
			thresh = interp1(iX, vDistSorted, fraction);
			
			% round thresh to nearest relevant digit
			vLessThanThresh = find(iX < fraction);
			nearestLessThanThresh = vDistSorted(vLessThanThresh(end));
			
			delta = thresh - nearestLessThanThresh;
			deltaOrder = 10^-floor(log10(delta));
			
			thresh = round(mean([thresh, nearestLessThanThresh])*deltaOrder)/deltaOrder;
			
			vDist = vDist(vDist > thresh);
		end
end
%% Output

[sThresh, sThresh2] = n2p(thresh);
end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
