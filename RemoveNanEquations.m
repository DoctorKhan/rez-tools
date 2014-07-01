function [mOut, vNaNMask, mNaNMask] = RemoveNanEquations(mIn, vNaNMaskIn)

%
% mOut = RemoveNanEquations(mIn, vNaNMaskIn);
%
% Removes all rows of the matrix where the last element is a NaN
% Only the last column may contain NaNs.
% Khan  03/25/09
%

%% Input must not contain NaN's except for last column


s = size(mIn);
lastCol=mIn(:,end);

if ~exist('vNaNMaskIn', 'var')
    % Compute mask based on last column of matrix.
    vNaNMask = lastCol ./ lastCol;
else
    % Apply input mask to matrix.
    vNaNMask = vNaNMaskIn;
end

mNaNMask = repmat(vNaNMask, 1, s(2));
mIn(isnan(mNaNMask))=[];
mOut = reshape(mIn,length(mIn)/s(2),s(2));

end
