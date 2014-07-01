function mCoords = VolMask2Coords(LogMask, view)

% mCoords = VolMask2Coords(LogMask, view);
%
%
%
% Khan 08/15/2011

%% Default params


%% Initialize


%% Main
mCoords = reshape(view.coords(repmat(HorzVec(LogMask), [3, 1])), 3, []);

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
