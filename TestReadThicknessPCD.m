% function TestReadThicknessPCD

% TestReadThicknessPCD;
%
%
%
% Khan 11/02/2011

%% Default params


%% Initialize
d = '/export/data/mri/Anatomy/GreeneHR/Cortex/Left/3DMeshes/White-Pia';

%% Main
[ctCoords, cmDepths, ~, cmThicks] = ReadThicknessPCD(d);

viDim = [300 300 300];
% viSurfs = [ 1 2 3 7 11 16];
viSurfs = 1:16;
mX = reshape(ctCoords(:,:,viSurfs), 3, []);
y = HorzVec(cmDepths(:,:,viSurfs));
v = sub2mat3d(mX, viDim, y);
pic(v(:,:,120)); colormap jet;

%%
% [x,y,z] = meshgrid(1:300,1:300,1:300);
% [x,y,z,v] = flow;f

% [x y z ] = Foliate(round(ctCoords));
% y = HorzVec(cmDepths);
% x = sub2ind3d(ctCoords,viDim);
% y = GridData(x, cmDepths(:), [], [], 20);


% p = patch(isosurface(x,y,z,v,1.25));
% isonormals(x,y,z,v,p)
% set(p,'FaceColor','red','EdgeColor','none');
% daspect([1 1 1])
% view(3); axis tight
% camlight 
% lighting gouraud

% end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
