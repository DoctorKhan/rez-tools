function view = MakeLayer1ROI(view)

% view = MakeLayer1ROI(view);
%
%
%
% Khan 12/20/2011
 
%% Default params


%% Initialize
nodes = GrayNodes(view);
coords = GrayCoords(view);

%% Main

vbLayer1 = nodes(6, :) == 1;
view = newROI(view, 'Layer 1', 'select', '', coords(:, vbLayer1));

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
