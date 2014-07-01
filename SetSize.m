function SetSize(width, height, h, units)

% SetSize(width, height, h);
% SetSize(h, v, units)
%
%
%
% Khan 12/29/2010

%% Default params
if notDefined('h'), h = gcf; end
if numel(height) > 1
	h = width;
	width = height(1);
	height = height(2);
end
%% Initialize
if ~isscalar(h)
	for hs = h
		SetSize(width, height, hs);
	end
	return;
end

%% Main


if defined('units')
	sUnitsBack = get(h, 'Units');
	set(h, 'Units', units);
    
    vPos = get(h, 'Position');
    set(h, 'Position', [vPos(1:2) width height]);

	set(h, 'Units', sUnitsBack);
else
    vPos = get(h, 'Position');
    set(h, 'Position', [vPos(1:2) width height]);
end

try set(h, 'FontSize', 12); catch; end


end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
