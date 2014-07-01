function [out, mask] = RemoveNaNVector(vIn)

%
% function [out, mask] = RemoveNaNVector(vIn);
%
% Removes NaN from each element of a vector
% The mask is a vector containing 1's and 0's indicating whether an 
% element should be ignored because it is NaN (0), or considered (1) for 
% statistical calculations.
%
% Khan 1/09
%

% Check if input is really a vector.
if ~isvector(vIn)
    Alert('Input is not a vector!');
    return
end

s = size(vIn);

if((s(1) == 1))
    % Remove NaN from each element of the row vector
    for i = 1:length(vIn)
        if ~isnan(vIn(i))
            vMask(i) = 1;
            if ~exist('vOut', 'var')
                vOut(1) = vIn(i);
            else
                vOut = horzcat(vOut, vIn(i));
            end
        else
            vMask(i) = 0;
        end
    end
    if notDefined('vOut')
        out = 0;
    else
        out = vOut;
    end
    mask = vMask;
else
    % Process column vector.
    out = RemoveNaNVector(vIn')';
end

end