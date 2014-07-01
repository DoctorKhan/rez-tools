function oView = Switch2(sViewType, oView, sDataType)

% oView = Switch2(sViewType, oView, sDataType);
%
%
%
% Khan 07/28/2011
% Khan 11/18/2011 - Made functional

mrGlobals
%% Default params


%% Initialize


%% Main

if ~strcmp(oView.viewType, sViewType)
	switch lower(sViewType)
		case 'volume'
    		oView = switch2Vol(oView);
		case 'gray'
        	oView = switch2Gray(oView);
		otherwise
			error('gray or vol only');
	end
end

if defined('sDataType') && ~strcmpi(dataTYPES(oView.curDataType), sDataType)
		oView = selectDataType(oView, sDataType);
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
