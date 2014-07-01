function oView = LoadMeanMap(oView)

% oView = LoadMeanMap(oView);
%
%
%
% Khan 01/23/2012
 
%% Default params


%% Initialize


%% Main
[oView, bLoaded] = loadMeanMap(oView);

if ~bLoaded
	oView = computeMeanMap(oView, 0);
	oView = setDisplayMode(oView, 'map');
	UpdateView(oView);
end


end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
