function o = CheckBoundBox(oA, oB, tolerance)

% o = CheckBoundBox(oA, oB, tolerance);;
%
%
%
% Khan 06/19/2012
 
%% Default params
Default tolerance = 5

%% Initialize
mA = BoundingBox(oA);
mB = BoundingBox(oB);

%% Main
vA = diff(mA);
vB = diff(mB);

[vA, viA] = sort(vA);
[vB, viB] = sort(vB);

% check permution
o.aligned(1) = ~any(viA-viB);

% check scale
o.scale = vB./vA;
o.aligned(2) = all(vB./vA < 1.09);

% check position
vPosA = mean(mA);
vPosB = mean(mB);

o.pos = vPosB-vPosA;
o.aligned(3) = all(abs(vPosA-vPosB) < tolerance);

o.BoxA = mA;
o.BoxB = mB;

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
