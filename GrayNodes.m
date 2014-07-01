function mGrayNodes = GrayNodes(oView)

% mGrayNodes = GrayNodes(oView);
%
%
%
% Khan 12/20/2011
 
%% Default params


%% Initialize



%% Main
oGrayNodes = Load(SessionDir(oView.sessionCode, 'Gray', 'coords.mat'));
mGrayNodes = oGrayNodes.nodes;

if defined('oView')
	mGrayNodes = CopyStruct(oView, oGrayNodes);
end

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
