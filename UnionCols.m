function mUnion = UnionCols(varargin)

% mUnion = UnionCols(varargin);
%
% Union of multiple 3xN, 3xM, etc. matrices.
%
% Khan 09/26/2011

%% Default params


%% Initialize
mVert1 = HorzMat(varargin{1})';

%% Main
for ii = 2:nargin
	mVert2 = HorzMat(varargin{ii})';
	[~, ia, ib ]= union(mVert1, mVert2,'rows');
	if ~isempty(ia)
		mVert1u = mVert1(sort(ia),:);
	else
		mVert1u = [];
	end
	
	if ~isempty(ib)
		mVert2u = mVert2(sort(ib),:);
	else
		mVert2u = [];
	end
	
	mVert1 = [mVert1u; mVert2u];
end

mUnion = mVert1';

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
