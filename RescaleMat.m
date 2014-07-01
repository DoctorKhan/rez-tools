function [m, scale, offset, maxVal] = RescaleMat(m, vBounds, mbMask)

% [m, scale, offset, maxVal] = RescaleMat(m, vBounds, mbMask);
%
% Puts values in matrix on a 0 to 1 range by scaling entire matrix.
%
% Khan 12/26/2010

%% Default params
if notDefined('vBounds'), vBounds = [0 1]; end

%% Initialize
spread = diff(vBounds);
newMin = vBounds(1);

%% Main
if notDefined('mbMask'), mbMask = true(size(m)); end

maxVal = max(m(mbMask));
offset = min(m(mbMask));
m = m - offset;

scale = range(m(mbMask));
m = m / scale;

m = m*spread + newMin;

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
