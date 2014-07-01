function MeshWhiteAndPia(oHemo)

% MeshWhiteAndPia(oHemo);
%
%
%
% Khan 12/29/2011

%% Default params


%% Initialize
for csHemi = {'Left', 'Right'}
	sHemi = csHemi{1};
	oHemis.(sHemi) = AnatPath(oHemo.sSubject, oHemo.sRegion, sHemi,  [sSubject, sHemi, '.Class' ]);
end

%% Main
Class2Mesh(oHemis.Left);
Surf2VistaFile(oHemo, 'Left', 'Pia');

Surf2VistaFile(oHemo, 'Right', 'Pia');
Class2Mesh(oHemis.Right);

[oBoth.White, oBoth.Pia] = CombMeshHemis(oHemo, 'White', 'Pia');

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
