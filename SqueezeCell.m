function cOut = SqueezeCell(cIn)

% cIn = SqueezeCell(cIn);
%
%
%
% Khan 08/29/2011

%% Default params


%% Initialize

%% Main
if iscell(cIn)
	cOut = cellfun(@CollapseCell, cIn, 'UniformOutput', false);
	cOut = CollapseCell(cOut);
    if iscell(cOut)
    	cOut(cellfun(@isempty, cOut)) = [];
    end
else
	cOut = cIn;
end

cOut = CollapseCell(cOut);

end % Function

function c = CollapseCell(c)
	while iscell(c) && isscalar(c)
		c = c{1};
	end
end

%% Note: type "doc hungarian" for variable prefix explanation.
