function SdfQa2(tSdf, oQual)

% SdfQa2(tSdf);
%
%
%
% Khan 06/07/2012

%% Default params

%% Initialize
[qf0 fFin0] = Destruct(oQual);

%% Main
g = Grad5p(tSdf);
qf = std(g(:) - 1);

qdelta = -Pch(qf0, qf);

if qdelta < 0
    s = 'decrease';
else
    s = 'increase';
end

Str(qdelta, '% quality', s)

fFin = fin(tSdf);
fChFin = Pch(fFin0, fFin);
if fChFin < 0
    nDelta = (fFin0 - fFin)*numel(tSdf);
    Str('Acquired', nDelta, 'non-finite voxels, a', fChFin, '% change.');
end


end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
