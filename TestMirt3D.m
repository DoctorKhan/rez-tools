function TestMirt3D

% TestMirt3D;
%
%
%
% Khan 04/03/2012
 
%% Default params


%% Initialize
t = cat(3,SampleTS, SampleTS);
t2 = permute(t,[2 1 3]);
% whos t
% cent(t)
mG = MeshGrid2(t);
[xg,yg,zg] = MeshGrid2(t);


%%
interp3(yg, xg, zg, t, yi, xi, zi)

%%
v = [3 2 4; 3 1 4];
LinearInterp(t, mG, v)
% [xi, yi, zi] = Foliate(v);

%% Main


end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
