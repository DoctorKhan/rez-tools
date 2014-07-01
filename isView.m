function bOut = isView(oView, sType)

% bOut = isView(oView, sType);
%
% Returns if oView is of type sType (Gray, Volume).
% To be implemented: (Inplane, 3View, Flat, ...)
%
% Khan 12/30/2011
 
%% Default params
Default sType = "Any";

%% Initialize


%% Main
switch TitleCase(sType)
	case {'Volume', 'Gray'}
		bOut = strcmpi(oView.viewType, sType);
	case 'Hidden'
		bOut = strcmpi(oView.name, 'hidden');
	case 'Any'
		bOut = isfield(oView, 'viewType');
	otherwise
		bOut = false;
end

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
