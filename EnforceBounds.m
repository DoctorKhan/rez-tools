function mCoords = EnforceBounds(mCoords, viDim)

% mCoords = EnforceBounds(mCoords, viDim);
%
%
%
% Khan 06/10/2012

%% Default params


%% Initialize


%% Main

for ii = 1:3
    vbBig = mCoords(ii,:) > viDim(ii);
    mCoords(ii,vbBig) = viDim(ii);
end
mCoords(mCoords < 1) = 1;

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
