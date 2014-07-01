function ConstructAllDomains(voHemo)
%
%
%
% Khan 07/10/2011

%% Default params
HemoInit

%% Initialize

%% Main
for oHemo = voHemo
     [ a, b ] = Domains4DepthMap(oHemo, 'Left',  nErodeLayers, nExtraLayers);
	 [a2, b2] =	Domains4DepthMap(oHemo, 'Right', nErodeLayers, nExtraLayers);
     cent(b + b2);
end

end
%% Note: type "doc hungarian" for variable prefix explanation.
