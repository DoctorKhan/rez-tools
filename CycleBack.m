function tData = CycleBack(tData, oBack)

% tData = CycleBack(tData, iDim, viDim);
%
%
%
% Khan 04/30/2012

%% Default params
Default iDim = 1 & viDim = size(tData);

%% Initialize
%% Main

% Reshape
c = oBack.ciDim;
tData = reshape(tData, c{:});

%% Permute
tData = DimShift(tData, -oBack.iShift);

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
