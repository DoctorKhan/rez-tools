function vi = Coords2Ind(oROI, view)

% vi = Coords2Ind(oROI, view);
%
%
%
% Khan 09/06/2011

%% Default params


%% Initialize


%% Main
vi = log2ind(Coords2Log(oROI,view));

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
