function [viIndices, vDistances] = nearpoints1d(vA, vB)

% nearpoints1d;
%
% Calls nearpoints3d.
%
% Khan 08/17/2011

%% Default params


%% Initialize
vA = HorzVec(vA);
nA = length(vA);
vB = HorzVec(vB);
nB = length(vA);

%% Main
mA = [vA; zeros(2, nA)];
mB = [vB; zeros(2, nB)];

[viIndices, vDistances] = nearpoints3d(mA, mB);
end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
