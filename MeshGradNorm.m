function [oMesh, oVol, vbInverted] = MeshGradNorm(oMesh, oVol, varargin)

% oMesh = MeshGradNorm(oMesh, pRawiv, varargin);
%
%
%
% Account 03/07/2012
% Khan 03/08/2012

%% Default params
if notDefined('oVol')
    pRawiv = [oMesh.filename 'iv'];
    oVol = Rawiv(pRawiv);
end

oMesh = RawMesh(oMesh);
oMesh.UnitsOff;
%% Initialize
% [mBox(1,:), vScale, tX, tY, tZ, tData] = 
Destruct(oVol);
% vertices = 
Destruct(oMesh);

%% Main
if ~isSub(oMesh, 'normals') ||  isempty(oMesh.normals) || Option('force');
    Str('Calculating gradient normals on mesh...');
            
    normals = nan(size(vertices));
    [mGoodVerts, vbGood] = Finite(vertices);
    mGoodVerts = MatrixVectorDiv(MatrixVectorDiff(mGoodVerts, mBox(1,:)), vScale);
    % calc normals
%     tSdf = permute(double(tData), [2 1 3]);
    tSdf = double(tData);
    mVertsPerm = mGoodVerts([2 1 3], :)';
%     [x, y, z] = Foliate(mGoodVerts, @VertMat);
   
    mIso = isonormals(tX, tY, tZ, tSdf, mVertsPerm, 'negate')'; %fin(mIso);
    normals(vbGood) = NormalizedVector(HorzMat(mIso));
       
    vSdf1 = LinearInterp(oVol, oMesh); %fin(vSdf1); % calc mGoodNorms
    
    oMesh.normals = normals; %fin(oMesh.normals);
    vSdf2 = LinearInterp(oVol, oMesh, 'normals'); %fin(vSdf2);% calc mGoodNorms 
    
    vbInverted = vSdf2 < vSdf1;

    if frac(vbInverted) > 0.5
        Str('Inverting all normals.');
        normals = -normals;
        vbInverted = ~vbInverted;
    end
    
%     normals(:,vbInverted) = -normals(:,vbInverted);
    Str(frac(vbInverted)*100, '% of the normals seem inverted.')
    
    oMesh.normals = normals; %fin(oMesh.normals); %fin(oMesh);
    oMesh.normtype = 'gradient';
    oMesh.normsrc = StructName(oVol);
end


end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
