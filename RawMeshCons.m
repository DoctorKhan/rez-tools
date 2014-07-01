function voRaw = RawMeshCons(sPre, iSurf, oBase, varargin)

% oRaw = RawMeshCons(sPre, varargin);
%
%
%
% Khan 04/09/2012

%% Default params 
Default oBase
%% Initialize

%% Main
if is3d(sPre)
    voInput = VolumeMesher(sPre, 1, '', 0, 5, 'Raw');
elseif isnumeric(sPre)
    voInput.vertices = HorzMat(sPre);
elseif isRawiv(sPre)
    pFile = sPre.filename(1:end-2);
    clear sPre; sPre = pFile;
elseif isObStruct(sPre);
    voInput = sPre;
    Destruct(voInput);
end

if ischar(sPre)
    if notDefined('iSurf')
        pFile = sPre;
        sSurf = regexprep(regexprep(sPre, '\..*', ''), '.*s', '');
        sPre = regexp(regexprep(sPre, '\..*', ''), '.*s', 'match');
        iSurf = Finite(str2double(sSurf));
    else
        pFile = FileExt(sPre, iSurf, 'raw', 'weakly');
    end
    voFiles = Ls(pFile);
    if ~isempty(voFiles)
        for oFile = voFiles;
            voInput(oFile.iNum) = ReadFileIntoMesh(oFile.name);
        end
    else
        error(Str('Could not find file', pFile));
    end
end
Default iSurf = 1


voInput.iSurf = iSurf;
Default nSurfs = 8;
voInput.nSurfs = nSurfs;
voInput.iFinal = nSurfs - 1;

voInput.sPrefix = sPre;

nVerts = length(voInput.vertices);
voInput.nVerts = nVerts;

voInput.miSurf = zeros(nVerts, nSurfs);
voInput.viSurf = zeros(1, nVerts);
voInput.tTraj = single(repmat(voInput.vertices, [1, 1, nSurfs]));
voInput.distance = zeros(1, nVerts);
voInput.initVertices = voInput.vertices;

% Copy data to object
for oInput = NumStruct(voInput)
    oRaw = RawMesh;
    for oField = Str2Struct(fieldnames(voInput(1))),
        oRaw.(oField.name) = voInput.(oField.name);
        oRaw = CopyStruct(oRaw, oBase);
    end
    oRaw.mmPerVox0 = oRaw.mmPerVox;
    voRaw(oInput.iNum) = oRaw;
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
