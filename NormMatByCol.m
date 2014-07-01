function mNorm = NormMatByCol(mIn, iCol)

% mNorm = NormMatByCol(mIn, iCol);
%
% Normalize a matrix by one of the columns
%
% Khan 05/11/2010

%% Default params


%% Initialize


%% Main


m = repmat(mIn(:,iCol), 1, size(mIn,2));
mNorm = mIn ./ m;

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
