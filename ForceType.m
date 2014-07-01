function xTyped = ForceType(xVar, varargin)

% xTyped = ForceType(xVar, varargin);
%
%
%
% Khan 01/15/2012

%% Default params


%% Initialize


%% Main
if Option('ROI')
	if Option('Gray')
		sView = 'Gray';
	else
		sView = 'Volume';
	end
	
	if ischar(xVar)
		xTyped = Load(SessionDir(sView, 'ROIs', xVar));
	elseif isnumeric(xVar)
		[~,~,~,oView] = Option(@isView);
		xTyped = oView.ROIs(xVar);
	elseif isstruct(xVar)
		if isfield(xVar, 'coords')
			xTyped = xVar;
		else
			xTyped = Load(SessionDir(sView, 'ROIs', xVar));
		end
	end
end
	
end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
