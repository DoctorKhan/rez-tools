function [vbIn mCoordsIn] = inBounds(mBoundCoords, mCoords, varargin)

% vbIn = inBounds(mBoundCoords, mCoords);
%
%
%
% Khan 04/02/2012

%% Initialize
mCoords = HorzMat(mCoords);

%% Main
try mBoundCoords = mBoundCoords.mBoundCoords; end

[mBounds vLower1 vUpper1] = BoundingBox(mBoundCoords);
[mBounds vLower2 vUpper2] = BoundingBox(mCoords);

% if all(vLower1 < vLower2 & vUpper2 < vUpper1);
%     vbIn = true(1, size(mCoords,2));
% else
mL = -(mCoords - vLower1);
mU = mCoords - vUpper1;
mOut = [mL; mU];
mbOut = mOut > 0;
mOut(~mbOut) = nan;
rmsOut = Rms(mOut(:));
vbOut = any(mbOut);
vbIn = ~vbOut;

if nargout == 0 || Option('verbose')
    Str(frac(vbOut)*100, '% out of bounds with RMS =', rmsOut);
end

mCoordsIn = mCoords(:, vbIn);
% end

%% Note: type "doc hungarian" for variable prefix explanation.
if nargout == 0 || Option('verbose')
    Str(frac(vbOut)*100, '% out of bounds with RMS =', rmsOut);
end

mCoordsIn = mCoords(:, vbIn);
% end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
