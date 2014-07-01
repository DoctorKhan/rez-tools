function mMat = VertMat(mMat, varargin)

% mMat = VertMat(mMat, sType);
%
% Forces matrix to be vertical (e.g. Nx3).
%
% Khan 11/02/2010

%% Initialize
mMat = HorzMat(mMat, varargin{:});
viPerm = 1:ndims(mMat);
viPerm(1:2) = [2 1];

%% Main
mMat = permute(mMat, viPerm);

end % Function

%% Note: type "doc hungarian" for variable prefix explanation.
