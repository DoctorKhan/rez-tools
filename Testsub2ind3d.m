m = [1 2 3; 4 5 6; 7 8 9]
vDims = [10 10 10]
coords2Indices(m, vDims)
v = sub2ind3d(vDims, m)
ind2sub3d(vDims, v)
indices2Coords(v, vDims)

n = uint16(m);
sub2ind3d(vDims, n)
sub2ind3d(n, vDims)