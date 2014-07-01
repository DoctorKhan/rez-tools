function viSize = GetSize(h, units)

% viSize = GetSize(h, units);
%
%
%
% Khan 08/04/2011

%% Default params
if notDefined('h'), h = gcf; end

%% Initialize

%% Main
if defined('units')
	unitsBack = get(h, 'Units');
	set(h, 'Units', units); 
	vP = get(h, 'Position');
	set(h, 'Units', unitsBack);
else
	vP = get(h, 'Position');
end

viSize = vP(3:4);

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
