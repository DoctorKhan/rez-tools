
% function TestDonut

% TestDonut;
%
%
%
% Khan 05/25/2012
 
%% Default params


% %% Initialize
l = 300;
c = l/2;
R = 75;

%% Main
[x y z] = MeshGrid2(l);

xc =x-c; 
yc=y-c; 
zc=z-c;

r = sqrt(xc.^2 + yc.^2);

dc = r-R;
d = sqrt(dc.^2 + zc.^2);

s = (xc + R)./(2.*R);
t = d < 30*s;

figure; Slide(t)
% end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
