function [m, vOrigin] = NormShift(m, vOrigin)

% [m, vOrigin] = NormShift(m, vOrigin);
% 
% 
% 
% Khan 12/07/2009

if ~exist('vOrigin', 'var')
    vOrigin = 2 - min(m,[],2);
end

m = m + repmat(vOrigin,1,size(m,2)); % Cartesian I quadrant

end
