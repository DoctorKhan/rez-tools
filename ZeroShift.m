function [m, vOrigin] = ZeroShift(m, vOrigin)

% [m, vOrigin] = ZeroShift(m, vOrigin);
% 
% 
% 
% Khan 12/08/2009

if ~exist('vOrigin', 'var')
    vMin = min(m,[],2); vMax = max(m,[],2);
    vOrigin = -2*(round((vMax + vMin)/4));
end

m = m + repmat(vOrigin,1,size(m,2)); % Zero centered

end

