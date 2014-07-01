% v = TestRadius(viSurf)
%
%
%
% Khan 03/16/2012

%% Default params
Default viSurf = 0:15

%% Initialize
v = [];
sPre = 'Inter400s';

%% Main
for iSurf = viSurf
    iSurfInd = iSurf+1;
    TextWaitbar(iSurf/15, 'Checking rawiv.');
    pRaw = St(sPre, iSurf, '.raw');
    pRawiv = St(pRaw, 'iv');
    
    oRawiv = ReadRawiv(pRawiv);
    [riv siv] = Radius(oRawiv);
    oRaw = ReadRawFileIntoMesh(pRaw);
    [r s] = Radius(oRaw);
    if defined('voMesh')
        f = Radius(voMesh(iSurfInd));
    else
        f = iSurf;
    end
    v(end+1,:) = [f 1 s riv siv]
    fin(oRaw)
end
v(:, 4) = linspace(v(1,3), v(end,3),length(v));

% end
%% Note: type "doc hungarian" for variable prefix explanation.
