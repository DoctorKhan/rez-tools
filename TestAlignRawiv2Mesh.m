% function TestAlignRawiv2Mesh

% TestAlignRawiv2Mesh;
%
%
%
% Khan 03/23/2012
 
%% Default params
Default oRawiv = "Inter400s0.rawiv";
Default oRaw = "Inter400s0.raw";

%% Initialize


%% Main
[oRawiv, oRaw, vAdj] = AlignRawiv2Mesh(oRawiv, oRaw);
vAdj = AlignMesh2Vol(oRaw, oRawiv);


%% Assessment
Str('Mean error:', merr);

if merr < 0.001
    Str Alignment succeeded!
else
    Str Alignment failed :(
end
% end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
