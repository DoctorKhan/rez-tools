function MeshAllClasses(voHemo, iIters, varargin)

% MeshAllClasses(voHemo, iIters, varargin);
%
%
%
% Khan 07/06/2011

%% Default params
HemoInit
Default iIters = 5 & sPia
Default sWhite = "White"
if Option('Pia')
    csTissues = {sWhite, 'Pia'};
else
    csTissues = {sWhite};
end

if Option('Both')
    csHemis =  {'Left', 'Right', 'Both'};
else
    csHemis =  {'Left', 'Right'};
end

%% Main
% matlabpool open 8
for oHemo = NumStruct(voHemo)
    cds(oHemo)
    
    for csTissue = csTissues, sTissue = csTissue{1};
        for csHemi = csHemis, sHemi = csHemi{1};
            oSeg = Seg(oHemo, sHemi);
            oMesh = oSeg.Mesh(iIters, sTissue, 'White');
            oMesh.filename = regexprep(oMesh.filename, '.Class.', '');
            oMesh.Save;
        end
    end
    
    TextWaitbar(oHemo, oHemo);
end

end %function
% matlabpool close

%% Note: type "doc hungarian" for variable prefix explanation.
