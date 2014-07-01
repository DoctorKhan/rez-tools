function mGrayCoords = GrayCoords(oView)

% mGrayCoords = GrayCoords(oView);
%
%
%
% Khan 12/14/2011
 
%% Default params


%% Initialize


%% Main
oGrayCoords = Load(SessionDir(oView.sessionCode, 'Gray', 'coords.mat'));
mGrayCoords = oGrayCoords.coords;

if defined('oView')
	mGrayCoords = CopyStruct(oView, oGrayCoords);
end

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
