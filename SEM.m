function tSEM = SEM(t4d, iDim)

% tSEM = SEM(t, iDim);
%
%
%
% Khan 12/08/2010

%% Initialize
viDim = size(t4d);

%% Default params
if notDefined('iDim'), iDim = length(viDim); end
    
%% Main
t = std(t4d, 0, iDim);

% vRep = ones(1, length(viDim));
% vRep(iDim) = viDim(iDim);

% tSEM = repmat(m, vRep)/sqrt(viDim(iDim));

tSEM = t./sqrt(viDim(iDim));

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
