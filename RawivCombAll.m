function RawivCombAll(oWhite, oPia, sPre, nFiles)

% RawivCombAll;
%
%
%
% Khan 03/15/2012
 
%% Default params
Default sPre = "Inter400s";
Default nFiles = 16;

%% Arg handling
if ~isstruct(oWhite) && isFile(oWhite)
    oWhite = ReadRawiv(oWhite);
end
if ~isstruct(oPia) && isFile(oPia)
    oPia = ReadRawiv(oPia);
end

%% Initialize
iMaxSurf = nFiles-1;
v2 = normalize(1:nFiles);
v1 = 1 - v2;

cWhite = Struct2Cell(oWhite);

[cPia, csFields] = Struct2Cell(oPia);
nFields = length(csFields);

cMerged = cell(nFields,1);

%% Main
for iSurf = 1:(nFiles-2)
    s2 = v2(iSurf+1);
    s1 = v1(iSurf+1);

    pMerged = St(sPre, iSurf, '.rawiv');
    
    cMerged{1} = pMerged;
    for iField = 2:nFields
        cMerged{iField} = cWhite{iField}*s1 + cPia{iField}*s2;
    end
    
    sFrac1 = St('(', s1*iMaxSurf, '/', iMaxSurf, ')');
    sFrac2 = St('(', s2*iMaxSurf, '/', iMaxSurf, ')');
    St('S', iSurf, ' = ', sFrac1, ' S0 + ', sFrac2, ' S', iMaxSurf);

    oMerged = cell2struct(cMerged, csFields);
    WriteRawiv(oMerged);
end

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
