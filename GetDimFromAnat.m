function viDim = GetDimFromAnat(oHemo)

% viDim = GetDimFromAnat(oHemo);
%
%
%
% Khan 07/19/2011

%% Default params

%% Initialize

%% Main
Default oHemo & sHemi

oHemo = Hemo(oHemo);
[~, viDim] = readVolAnatHeader(VAnatPath(oHemo));

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
