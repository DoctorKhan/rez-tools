function mN = NormalizedVector(mN)

% mN = NormalizedVector(mN);
%
% Returns the matrix normalized by the L2 norm of each column of the input matrix.
%
% Khan 03/02/2010

%% Default params


%% Initialize
if isVertMat(mN)
    iDim = 2;
    viRep = [1, size(mN,2)];
else
    iDim = 1;
    viRep = [size(mN,1), 1];
end

%% Main
mNn = sqrt(sum(mN.^2, iDim));
mN = mN ./ repmat(mNn, viRep);

end %function


%% Note: type "doc hungarian" for variable prefix explanation.
