function CombineTrajectHemis(voHemo)

% CombineTrajectHemis(voHemo);
%
%
%
% Khan 05/30/2012

%% Default params
HemoInit

for oHemo = voHemo
%% Initialize
Destruct oHemo
csVars = {'distance', 'thickness', 'curvature', 'normdepth', 'tWthick', 'tWdepth', 'tWcurve', 'tW'};

%% Main
for csVar = csVars, sVar = csVar{1};
    try
        oLeft  = load(AnatPath(oHemo, 'Left',  'Laminae.mat'));
        oRight = load(AnatPath(oHemo, 'Right', 'Laminae.mat'));
        pBoth  = AnatPath(oHemo, 'Both', 'Laminae.mat');
        
        t4Both = cat(4, oLeft.(sVar), oRight.(sVar));
        
        oBoth.(sVar) = min(t4Both, [], 4);
        Destruct(oBoth);
        
        save(pBoth, sVar, '-append');
    end
end
end

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
