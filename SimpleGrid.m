function [t, m, viIndices] = SimpleGrid(m, mSample)

% [t, m, viIndices] = SimpleGrid(m);
% 
% 
% 
% Khan 12/07/2009

m = double(m);

if ~exist('mSample', 'var')
    nRows = max(m(:));
    t = zeros(nRows,nRows,nRows);
    %     t = false(nRows,nRows,nRows);
else
    t = zeros(size(mSample));
%     t = false(size(mSample));
end

s = size(t);

viIndices = m(1,:) + s(1)*m(2,:) + s(1)*s(2)*m(3,:);
t(viIndices) = 1;
% t(viIndices) = true;

end
