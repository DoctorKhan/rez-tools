function mask = ThresholdMask(input, fraction)

%
% mask = ThresholdMask(input, fraction);
%
% Returns a mask (per frame) where elements less than fraction*max (per frame) is set
% to NaN and everything else is set to 1.
%
% Khan 01/12/09
%

w = abs(input) .^2;

s = size(w);

switch length(s)
    case 2
        threshold = fraction*max(max(w));
        mask = w / threshold;
        mask = floor(mask);
        mask = mask / 0;
        mask(isinf(mask)) = 1;
    case 3
        %vThreshold = fraction*max(max(w, [], 2), [], 3);
        for it = 1:s(1)
            mask(it,:,:) = ThresholdMask(squeeze(input(it,:,:)), fraction);
        end
    otherwise
        Alert('Must be 2 or 3 dimensional object');
        return;
end
end
