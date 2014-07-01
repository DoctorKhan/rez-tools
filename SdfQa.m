function oQuality = SdfQa(tSdf, oQuality, varargin)

% oQuality = SdfQa(tSdf, oQuality, varargin);
%
%
%
% Khan 06/07/2012

%% Default params

%% Initialize

%% Main

g = Grad5p(tSdf);
QualityFactor = abs(nanstd(g(:) - 1));

if notDefined('oQuality')
    
    oQuality.FractionFinite = fin(tSdf);
    oQuality.QualityFactor = QualityFactor;
else
    FractionFinite = oQuality.FractionFinite;
    
    qdelta = -Pch(oQuality.QualityFactor, QualityFactor);
    
    if qdelta < 0
        s = 'decrease';
    else
        s = 'increase';
    end
    
    Str('Sdf quality:', qdelta, '%', s);
    oQuality = qdelta;
    
    fFin = fin(tSdf);
    fChFin = Pch(FractionFinite, fFin);
    if fChFin < 0
        nDelta = (FractionFinite - fFin)*numel(tSdf);
        Str('Acquired', nDelta, 'non-finite voxels, a', fChFin, '% change.');
    end
end
end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
