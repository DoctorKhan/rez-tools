function PlotFill(oX, oY, varargin)

% PlotFill(oX, oY);
%
%
%
% Khan 01/07/2012
 
%% Default params
Destruct(oX)
Destruct(oY)

scale = Default(1);
vColor = Default(0);

%% Initialize
hold on

if isscalar(vColor)
	o = ColorMapper;
	vColor = o.GetColors(vColor);
end

vAlpha = [ 0.5 0.3];
[vX vBot vMid vTop] = HorzVec(vX*scale, oY.lower, oY.mean, oY.upper);
vB = [vX Rev(vX)];

vY1 = [vTop Rev(vMid)];
vY2 = [vMid Rev(vBot)];

vbGood1 = isfinite(vY1);
vbGood2 = isfinite(vY2);

vLineWidths = [ 0.5 1 1.5 ];

%% Main
csArgs = {vColor, 'LineStyle', '-', 'LineWidth', vLineWidths(2), ...
	'FaceColor', vColor, 'FaceAlpha', vAlpha(1), 'EdgeColor', vColor, ...
	'EdgeAlpha', vAlpha(2)};

hP1 = patch(vB(vbGood1), vY1(vbGood1), csArgs{:});
hP2 = patch(vB(vbGood2), vY2(vbGood2), csArgs{:});

LegendDispOff([findobj(hP1); findobj(hP2)]);

hP = plot(vX, vMid, 'Color', vColor, 'LineWidth', vLineWidths(1)); hold on

% Fit data
if defined('oFit')
	Destruct oFit
	hF = plot(vXf*scale, vYf, 'LineWidth', vLineWidths(3), 'Color', vColor);
	LegendDispOff(findobj(hF));
end

if notDefined('sLegend')
	slope = vFitParams(1)./scale;
	p = vP(1);

    sLegend = Str('s =', RoundTo(slope,3), ', p =', RoundSig(p,3));

	if regexpi(oY.label, 'fwhm')
        sMiddle = Str(sType(1), '=', RoundTo(middle,2));
		sLegend = [sMiddle ', ' sLegend];
	end
end

set(hP, 'DisplayName', sLegend);

FixFigLimits(1.2);
end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
