function oMesh = QuillInterp(oMesh, oQuill)

% [oMesh, vDistance] = QuillInterp(oMesh, oQuill);
%
%
%
% Khan 04/11/2012

%% Default params
Destruct(oQuill);

%% Initialize
disp('Finding trajectory-mesh intersections...');
vbStopped = oQuill.viStop > 1;

viCol = find(vbStopped);

viStop = viStop(vbStopped);
viPrev = viStop-1;

[nSteps, nVerts] = size(mQuill);

%% Main

viY1 = sub2ind([nSteps nVerts], viPrev, viCol);
viY2 = sub2ind([nSteps nVerts], viStop, viCol);

mY(1,:) = mQuill(viY1);
mY(2,:) = mQuill(viY2);

mX(1,:) = vSteps(viPrev);
mX(2,:) = vSteps(viStop);

vDelta = -mY(2,:).*diff(mX)./diff(mY);
mDelta = zeros(size(oMesh.normals));
mDelta(:, vbStopped) = MatrixVectorProd(oMesh.normals(:,vbStopped), vDelta);

Str('SDF minimum found for', frac(vbStopped)*100, '% of the points.');
%% Calculate
oMesh.mDelta = mDelta;
oMesh.vbStopped = vbStopped;
%% Output
disp('Finished quill trajectory.');
end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
