function [mMat viDim] = HorzMat(mMat, varargin)

% mMat = HorzMat(mMat, sType);
%
% Forces matrix to be horizontal (e.g. 3xN).
%
% Khan 10/12/2010

%% Initialize
if iscolvector(mMat)
    mMat = mMat';
return
end

%% Main
[~, iDim, ~, viDim] = CoordInfo(mMat);

viPerm = 1:length(viDim);
viPerm(iDim) = [];
viPerm = [iDim viPerm];

mMat = permute(mMat, viPerm);

if ndims(mMat) > 2
    mMat = reshape(mMat, size(mMat,1), []);
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
