% function TestLinearInterp

% TestLinearInterp;
%
%
%
% Khan 04/08/2012
 
%% Default params


%% Initialize
t = SampleTS;
oVol = Rawiv(t);
oVol.mBox(1,:) = [1 1.5 1];
oVol.vScale = [2 1 1];
o.vertices = [7 4 5]';
%% Main
LinearInterp(oVol, o)
m = MatrixVectorDiv(MatrixVectorDiff(o.vertices,oVol.mBox(1,:)), oVol.vScale);
[x y z] = Foliate(m);
interp3(oVol.tData, y, x, z)

% end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
