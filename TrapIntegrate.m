function [integral, moment1] = TrapIntegrate(v, dt, iTimeOfOrigin)

%%
if ~exist('dt', 'var'), dt = 4; end

if ~isvector(v)
    weight = v(1,3) / 32767;
    v = v(:,2)*weight;
end

%%
v = colvector(v);
integral = sum(v);
integral = integral*dt;
pbeg = iTimeOfOrigin-length(v);
time = -(iTimeOfOrigin-pbeg-1):0;
moment1 = dt*(sum(v.*time'));
end