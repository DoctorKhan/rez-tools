function TestCalcTrajectories

% TestCalcTrajectories;
%
%
%
% Khan 11/02/2011

%% Default params


%% Initialize
iGridSize = 350;
nSurfaces = 16;
HemoInit

%% Main
oTraj = CalcTrajectories(oSphere, 'White', 'Pia', iGridSize, nSurfaces, '345');

%%
oSphere.sHemi = 'Right';
CalcTrajectories(oHemi, 'White.obj', 'Pia.obj', iGridSize, nSurfaces);

%%
% Destruct(oSphere); cds oSphere;
% oTraj = 
CalcTrajectories(oSphere, 'White', 'Pia', iGridSize, nSurfaces, '5');
%%
viDim = [300 300 300];

for ii = 1:16
	c{ii} = sub2log3d(oTraj.tCoords(:,:,ii), viDim);
end
%%
for ii = 1:3
	d = CombineMatrices(c{ii}, tbGray);
	pause(1);
	figure(ii)
	cent(d);
end
%%
% sl = m(1:2,abs(m(3,:) - 150) < 1);
tc = sub2log3d(m);
cent(tc+3*tbGray); hold on
% plot(sl(1,:), sl(2,:), 'y.')

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
