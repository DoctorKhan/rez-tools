function [oWhite, oPia] = GetMesh(oHemo, sHemi, varargin)

% [oWhite, oPia] = GetMesh(oHemo, sHemi, varargin);
%
% Return the meshes. sHemi = Left, Right, or Both
%
% Khan 07/02/2010

%% Defaults
Default oHemo = HemoFromDir
% 
% if ischar(oHemo)
%     sSubject = oHemo;
% else
%     Destruct(oHemo, 'weakly');
% end

Destruct(oHemo, 'weakly');
Default sRegion = "Cortex" & sHemi = "Both"

%% Main
pWhite = AnatPath(oHemo, sHemi, St(oHemo, sHemi, 'White.raw'));
oWhite = RawMesh(pWhite);

if nargout > 1
    pPia   = AnatPath(oHemo, sHemi, St(oHemo, sHemi, 'Pia.raw'));
    oPia = RawMesh(pPia);
end

if Option('pia')
    [oWhite, oPia] = swap(oWhite, oPia);
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
