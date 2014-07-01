function cOut = RemoveNaNMatrix(mIn, mMask)

%
% cOut = RemoveNaNMatrix(mIn, mMask)
%
% Removes NaN from each element of a matrix
% The mask is a vector containing 1's and 0's indicating whether an 
% element should be ignored because it is NaN (0), or considered (1) for 
% statistical calculations. Output is a cell structure (index = time) 
% where each element is a row vector.
%
% Khan 1/09
%

s = size(mIn);

%% Argument validation
% Check if input is really a matrix.
if (length(s) ~= 2)
    Alert('Input is not a matrix!')
    return
end

%% 
% Progress bar
wbProgress = waitbar(0, 'Removing NaNs...');

%s(1) = 10;

for it = 1:s(1)
    vIn = mIn(it,:);
    % Update progress
    waitbar(it/s(1), wbProgress, ['Removing NaNs... ', num2str(it), '/', num2str(s(1))]);
    [vOut, vMask] = RemoveNaNVector(vIn);
    if (vOut == 0)
        %ignore
    else
        cOut{it} = vOut;
    end
end

close(wbProgress);

end