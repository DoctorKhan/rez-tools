function m3 = PercentChange(m1, m2)

% m3 = PercentChange(m1, m2);
%
% (m2 - m1) * 100 / m1
%
% Khan  02/27/09
% Khan 06/07/2012 - changes zero m1 to 1.

vbZero = abs(m1) < 2*eps;

m1(vbZero) = m1(vbZero) + 1;
m2(vbZero) = m2(vbZero) + 1;

m3 = (m2./m1 - 1)*100;
 
%% Note: type "doc hungarian" for variable prefix explanation.
