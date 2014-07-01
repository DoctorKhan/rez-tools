function tsInflated = InflateSpatialElements(mFlattened, m, n)

s = size(mFlattened);

if exist('m', 'var')
    if ~exist('n', 'var'), n = s(2) / m; end
    tsInflated = reshape(mFlattened, s(1), m, n);
end

end