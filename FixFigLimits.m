function FixFigLimits(scaleFac, hAxes)

% FixFigLimits(scaleFac);
%
%
%
% Khan 01/08/2012
 
%% Default params
Default scaleFac = 1;
Default hAxes = gca;

%% Initialize
v = findall(hAxes);

%% Main
vX = []; 
for ii = 1:length(v)
	o = get(v(ii)); 
	if isfield(o, 'XData') && ~isscalar(o.XData)
		vX = [vX; o.XData(:)];
	end
end

vY = []; 
for ii = 1:length(v)
	o = get(v(ii)); 
	if isfield(o, 'YData') && ~isscalar(o.YData)
		vY = [vY; o.YData(:)];
	end
end

vbBad = ~isfinite(vX) | ~isfinite(vY);
vX(vbBad) = [];
vY(vbBad) = [];

xlim(minmax(vX));
vWinY = minmax(vY);
ylim(ScaleWin(vWinY, scaleFac));

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
