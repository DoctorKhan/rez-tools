function LegendDisp(h, s)

% LegendDisp(h, s);
%
% Turn display of object in legend on or off.
%
% Khan 01/08/2012
 
%% Default params


%% Initialize


%% Main
try
	set(get(get(h,'Annotation'),'LegendInformation'),  'IconDisplayStyle', s);
end

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
