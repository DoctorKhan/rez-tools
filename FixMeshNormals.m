function oMesh = FixMeshNormals(oMesh, oRawiv, varargin)

% oMesh = FixMeshNormals(oMesh, oRawiv, varargin);
%
%
%
% Khan 04/10/2012

%% Default params


%% Initialize

%% Main
vSdf1 = LinearInterp(oRawiv, oMesh); %fin(vSdf1); % calc mGoodNorms
vSdf2 = LinearInterp(oRawiv, oMesh, 'normals'); %fin(vSdf2);% calc mGoodNorms

vbInverted = vSdf2 < vSdf1;

if frac(vbInverted) > 0.5
    Str('Globally inverting all normals. Checking for local inversion...');
    oMesh.normals = -oMesh.normals;
    vbInverted = ~vbInverted;
end

if Option('all')
    oMesh.normals(:,vbInverted) = -oMesh.normals(:,vbInverted);
    Str(frac(vbInverted)*100, '% of the normals were uninverted.')
else
    Str(frac(vbInverted)*100, '% of the normals left inverted.')
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
