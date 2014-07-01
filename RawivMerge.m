function oMerged = RawivMerge(oWhite, oPia, w)

% oMerged = RawivMerge(oWhite, oPia, w);
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
% v2 = 1-w;
% v1 = w;

cWhite = Struct2Cell(oWhite);

[cPia, csFields] = Struct2Cell(oPia);
% nFields = length(csFields);

% cMerged = cell(nFields,1);

%% Main
%     s2 = v2;
%     s1 = v1;
    
%     cMerged{1} = pMerged;

%     for iField = 2:nFields
%         cMerged{iField} = cWhite{iField}*s1 + cPia{iField}*s2;
%     end
    
    cMerged = CellFun(@(a, b) WtdMean(a,b,w), cWhite, cPia);
    Str('S =', w, 'S1 +', 1-w, 'S2');

    oMerged = cell2struct(cMerged, csFields);
%     WriteRawiv(oMerged);

end % Function

function c = WtdMean(a, b, w)
    if ischar(a)
        c = a;
    else
        c = w*a + (1-w)*b;
    end
end

%% Note: type "doc hungarian" for variable prefix explanation.
