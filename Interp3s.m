function vDataOnMesh = Interp3s(tbDomain, tbData, mMesh, sMethod, varargin)

% vDataOnMesh = Interp3s(tbDomain, tbData, mMesh, sMethod, varargin);
%
%
%
% Khan 12/27/2011

%% Default params
Default sMethod = "nearest";

%% Initialize
if is3d(tbDomain)
	v = tbData(tbDomain);
end

if isfield(tbDomain, 'mmPerVox')
	tbDomain = tbDomain.vertices./tbDomain.mmPerVox;
end
if isfield(mMesh, 'mmPerVox')
	mMesh = mMesh.vertices./mMesh.mmPerVox;
end

[x, y, z] = Foliate(tbDomain, @VertVec);
[xi yi zi] = Foliate(mMesh, @VertVec);

%% Main
Str('Interpolating', dquote(inputname(2)), 'at coordinates in', ...
	dquote(inputname(1)), 'onto domain', dquote(inputname(3)), 'using', ...
	sMethod, 'interpolation...');

tic; warning off %#ok<*WNOFF>
MeshDepth = TriScatteredInterp(x, y, z, v, regexprep(sMethod, ' .*', ''), varargin{:});
warning on %#ok<*WNON>

vDataOnMesh = MeshDepth(xi, yi, zi);

toc; disp Complete.

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
