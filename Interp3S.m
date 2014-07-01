function vInterp = Interp3S(oRawiv, mCoords2, varargin)

% vInterp = Interp3S(oRawiv, mCoords2, varargin);
%
%
%
% Khan 03/19/2012

%% Default params

%% Initialize
try mCoords2 = mCoords2.mCoords; end

if isscalar(mCoords2), mCoords2 = true(mCoords2, mCoords2, mCoords2); end
if islogical(mCoords2), [mCoords2, viDim] = log2sub3d(mCoords2); end

mCoords1 = oRawiv.mCoords;
tData = oRawiv.tData;

[x y z] = Foliate(mCoords1, @unique);
[xx yy zz] = meshgrid(x, y, z);

[x, y, z] = Foliate(mCoords2, @unique);


%% Main
tic; warning off %#ok<*WNOFF>
vbGood = ~isBetween(minmax(xx), x) | ~isBetween(minmax(yy), y) | ...
~isBetween(minmax(zz), z);

vInterp = nan(1, length(x));
vInterp(vbGood);
x = x(vbGood)';
y = y(vbGood)';
z = z(vbGood)';
[xx2 yy2 zz2] = meshgrid(x, y, z);
a = interp3nan(xx, yy, zz, tData, xx2, yy2, zz2, 'linear'); fin(a)
if defined('viDim')
    vInterp = reshape(vInterp, viDim);
end
% MeshDepth = TriScatteredInterp(x, y, z, v, regexprep(sMethod, ' .*', ''), varargin{:});
warning on %#ok<*WNON>

% vDataOnMesh = MeshDepth(xi, yi, zi);

toc; disp Complete.

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
