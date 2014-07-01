function vdYdx = Deriv5p(tY, iDim, dx)

% vdYdx = Deriv5p(tY, dx);
%
%
%
% Khan 02/02/2012 - five point stencil Deriv5p
% Khan 05/20/2012 - end points are now O(h^2) accurate
 
%% Default
Default dx = 1;
Default iDim = 1;
%% Prepare
[tY, oBack] = CycleFirst(tY, iDim);

%% Main routine
vdYdx = (circshift(tY, 2) - 8*circshift(tY, 1)  + 8*circshift(tY, -1) - circshift(tY, -2)) ./ (12*dx);

vdYdx(1,:) = sum([-3 4 -1].*tY(1:3,:)) ./ 2*dx; % Forward Deriv5p O(h^2)
vdYdx(2,:) = sum([-1 0  1].*tY(1:3,:)) ./ 2*dx; % Central Deriv5p O(h^2)

vdYdx(end,:)   = sum([1 -4 3].*tY(end-2:end,:)) ./ 2*dx; % Backward Deriv5p O(h^2)
vdYdx(end-1,:) = sum([-1 0 1].*tY(end-2:end,:)) ./ 2*dx; % Central Deriv5p O(h^2)

vdYdx = CycleBack(vdYdx, oBack);
end
 
%% Note: type "doc hungarian" for variable prefix explanation.
