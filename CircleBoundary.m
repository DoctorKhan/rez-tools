function [ vCircle ] = CircleBoundary(mGrid, cCenterPos, circleRadius)

% [ vCircle ] = CircleBoundary(mGrid, cCenterPos, circleRadius);
%
% CircleBoundary outputs a set of complex coordinates corresponding to a circle boundary
% Inputs: circleRadius = the radius of the circle
%
% Khan 10/09

%% Initialize
dx = mGrid(1,2) - mGrid(1,1);
ds = dx/2; % Arc length step size.
% using s = r * theta  => ds = r * dtheta
dtheta = ds/circleRadius;

% Assign theta
vTheta = 0:dtheta:2*pi;
vcCircle = cCenterPos + circleRadius*exp(i*vTheta); % points in circle;
viCircle = nearpoints2d(vcCircle,mGrid); % round to grid points
% remove duplicate points
viCircleUniq = viCircle(1);
for ii = 2:length(viCircle)
    if viCircle(ii) ~= viCircle(ii - 1)
        viCircleUniq = [viCircleUniq, viCircle(ii)];
    end
end

%% Output
vCircle = mGrid(viCircleUniq);

end
