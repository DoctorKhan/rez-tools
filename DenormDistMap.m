% function DenormDistMap

% DenormDistMap;
%
%
%
% Khan 04/30/2012
 
%% Default params


%% Initialize


%% Main
Destruct(o);
[gx gy gz] = gradient(tNorm);

N = sqrt(gx.^2 + gy.^2 + gz.^2);
nx = gx./N; ny = gy./N; nz = gz./N;

t = 1./N;
d = tNorm.*t;
%%

% end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
