function oSub = SubjectCons(oHemo, oHemi, varargin)

% SubjectCons(oIn, varargin);
%
%
%
% Khan 05/16/2012
 
%% Default params


%% Initialize
oHemi.sHemi = 'Both';

%% Main
oL = load(AnatPath(oHemo, 'Laminae.mat'));
try 
sdf = Rawiv(oL.laminae);
catch
    sdf = Rawiv(oL.tNorm);
end
pPia = AnatPath(oHemo, '3DMeshes', 'Pia.mat');
pia = RawMesh(pPia);

pWhite = AnatPath(oHemo, '3DMeshes', 'White.mat');
white = RawMesh(pWhite);

oSub = Struct(oHemo, oHemi, sdf, pia, white);

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
