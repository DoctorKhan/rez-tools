% function ISMRM2011

% ISMRM2011;
%
%
%
% Khan 11/30/2011
 
%% Default params


%% Initialize
HemoInit
% if ishandle(1), hold on; end

%% Main
for oHemo = voHemo
	cds(oHemo)
	Ls *3D*V123*
	FiguresHRF *3D*V123*
	figure;
% 	hold off
end
% cds oGreene
% sl B*20D*V1pt*2p4*3*
% FiguresHRF B*20D*V1pt*
% end % Function


%% 198 55 173
t0 = o.laminae; % axial, coronol, saggital
c = {60, 205, 173};

cv = CellFun(@(x) (x-15):(x+5), c);
t = t0(cv{:});
t = LaplaceMultiplier(t, ~isfinite(t));
%%
t = interp3(t);
cent(t,3)

%%
[u v w] = gradient(t);

%%
cs = num2cell(round(size(t)/2));
% [y x z] = MeshGrid2(t);
% [verts averts] = streamslice(u,v,w,cs{:}); 

% load wind
% [verts averts] = streamslice(u,v,w,10,10,10); 
spd = sqrt(u.^2 + v.^2 + w.^2);
imagesc(spd(:,:,cs{3}));
hold on; 
streamline([verts averts]);
% colormap(hot)
% shading interp
% view(30,50); axis(volumebounds(spd));
% camlight; material([.5 1 0])

%%

mrVista3D;
VOLUME{1} = selectDataType(VOLUME{1}, 'Timed');
VOLUME{1} = ComputeLaminarDistance(VOLUME{1},[], 'normalized');
VOLUME{1} = switch2Gray(VOLUME{1});
VOLUME{1} = loadROI(VOLUME{1}, 'V1p', 'select');
for ii = 6:9
VOLUME{1}.map{ii} = GetMapInROI(VOLUME{1}.map{3}, VOLUME{1}, 1);
VOLUME{1}.mapAnnotation{ii} = 'Thickness in ROI';
end
%% Note: type "doc hungarian" for variable prefix explanation.
