function ComputeNormSdf(oHemo)

% ComputeNormSdf;
%
%
%
% Khan 05/30/2012

%% Default params


%% Initialize
Destruct oHemo

%% Main
for csHemi = {'Left', 'Right', 'Both'}, sHemi = csHemi{1};
    pWhite = AnatPath(oHemo, sHemi, [sSubject, sHemi, 'WhiteSdf.rawiv']);
    pPial  = AnatPath(oHemo, sHemi, [sSubject, sHemi, 'PiaSdf.rawiv'  ]);
    
    % Normalized map
    oSdfWhite = Rawiv(pWhite);
    oSdfPial  = Rawiv(pPial);
    
    tS1 = oSdfWhite.tData;
    tS2 = oSdfPial.tData;
    
    tW = tS1./(tS1 - tS2);
    
    % Curvature (gyrality)
    tWcurve = GradSq5p(tW);
    
    % Thickness
    tWthick = 1./GradMag(tW);
    
    % Depth
    tWdepth = tW.*tWthick;
    
    % Domain
    tbDomain = tW > -1 & tW < 2;
    tW(tW < -1.5) = nan; 
    tW(tW > 2.5) = nan;
    
    % Output
    pLaminae = fullfile(fileparts(oSdfWhite.filename), 'Laminae');
    Str('Saving maps to', pLaminae);
    Save(pLaminae, tW, tWdepth, tWthick, tWcurve, tbDomain);    
end


end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
