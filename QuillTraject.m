function oMesh = QuillTraject(oMesh, oRawiv, vSteps, iSurf, varargin)

% oMesh = QuillTraject(oMesh, oRawiv, vSteps, iSurf, varargin);
%
%
%
% Khan 04/11/2012

%% Default params
Default vSteps = 0:0.1:8;
iDir = 1 - 2*Option('reverse');

%% Initialize
vertices = oMesh.vertices;
normals = iDir*oMesh.normals;

if isempty(oMesh.iSurf) || oMesh.iSurf == 0
    Default iSurf = oRawiv.iSurf;
else
    Default iSurf = oMesh.iSurf;
end

oMesh.iSurf = iSurf;

nVerts = length(vertices);
nSteps = length(vSteps);
mQuill = nan(nSteps, nVerts, 'single');
vbStopped = false(1, nVerts);

fStalled = 0;

%% Main
ds = diff(vSteps(1:2));

dX = normals*ds;
dC = zeros(size(dX));
vbPassed = false(1, nVerts);

vY1 = iDir*LinearInterp(oRawiv, oMesh);

for iStep = 1:nSteps
    try
        mQuill(iStep,:) = vY1;
        vertices = vertices + dX - dC;
        dX(:,vbPassed) = 0;
        
        vY2 = iDir*LinearInterp(oRawiv, vertices);
        
        vbPassed = ~vbStopped & vY2 >= 0 & vY1 < 0;
        
        dC = MatrixVectorProd(normals, ds*vY2./(vY2-vY1));
        dC(:,~vbPassed) = 0;
        
        vbStopped = vbStopped | vbPassed;
        
        if any(vbPassed) && fStalled > 0
            fStalled = 0;
        else
            fStalled = fStalled + 1/nSteps;
        end
        
        if fStalled > 0.1 || all(vbStopped), break; end
        
        % Update previous
        vY1 = vY2;
        TextWaitbar(iStep/nSteps, 'Evolving quills.');
    catch oMe, oMe.stack(end), oMe.message, keyboard
    end
end

oMesh.vbStopped = vbStopped;
oMesh.vbGood = vbStopped;
oMesh.vbLanded = vbStopped;

% Update successful points
oMesh.vertices(:,vbStopped) = vertices(:,vbStopped);

oMesh.Update(iSurf);

oMesh.tTraj(:,:,iSurf+1) = single(vertices);

oMesh.viSurf(oMesh.vbStopped) = uint8(iSurf);
oMesh.miSurf(:, iSurf+1) = oMesh.viSurf(:);

viSurf = oMesh.viSurf;
oMesh.vbOldFailure = abs(viSurf - iSurf) > 1;
oMesh.vbNewFailure = abs(viSurf - iSurf) == 1;

Str('SDF zero crossed for', frac(vbStopped)*100, '% of the points.');
FinalError = LinearInterp(oRawiv, vertices(:, vbStopped));
mss(FinalError);

%% Output

disp('Finished quill trajectory.');
end
%% Note: type "doc hungarian" for variable prefix explanation.
