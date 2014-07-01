function value = restrict(value, lower, upper, varargin)

% value = restrict(value, lower, upper);
%
% restrict a value to a range.
%
% Khan 11/18/2011

%% Argument handling
Default upper = Inf & lower = -Inf
lower = MixedMatch(lower, value);
upper = MixedMatch(upper, value);
%% Main

if Option('remove');
	value(value < lower | value > upper) = [];
else
	value(value < lower) = lower(value < lower);
	value(value > upper) = upper(value > upper);
end

end

%% Note: type "doc hungarian" for variable prefix explanation.
