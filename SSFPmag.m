function [Mss, optAlpha, optMss] = SSFPmag(TR, alpha, T1, T2)

% Mss = SSFPmag(TR, alpha, T1, T2);
%
% Ress, 8/08

E1 = exp(-TR./T1);
E2 = exp(-TR./T2);
alpha = pi/180 .* alpha;
Mss = (1 - E1) .* sin(alpha) ./ (1 - (E1 - E2).*cos(alpha) - (E1.*E2));

optAlpha = acos((E1 - E2) ./ (1 - E1*E2));
optMss = (1 - E1) ./ sqrt((1 - E1*E2).^2 - (E1 - E2).^2);
optAlpha = 180/pi * optAlpha;


end

