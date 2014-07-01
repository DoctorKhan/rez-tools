function sRegion = GetRegion(oHemo)

% sRegion = GetRegion(oHemo);
%
%
%
% Khan 01/25/2012

%% Default params
Default cpAnat | sRegion;


%% Initialize
pSession = SessionDir('mrSESSION.mat');

%% Main
if GetRegionFromDir
    sRegion = GetRegionFromDir;
elseif exist(pSession, 'file')
    load(pSession);
    if isfield(mrSESSION, 'segmentation') && ~isempty(mrSESSION.segmentation)
        sRegion = mrSESSION.segmentation;
    end
end

if ~isRegion(sRegion)
    sRegion = [];
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
