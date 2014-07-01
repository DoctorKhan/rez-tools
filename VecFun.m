function vOut = VecFun(fhName, v)

% vOut = VecFun(fhName, v);
%
%
%
% Khan 01/08/2012
 
%% Default params

%% Initialize
vOne = fhName(v(1));
if isNumScalar(vOne)
	vOut = repmat(vOne, size(v));
else
	vOut = repmat({vOne}, size(v));
end

%% Main
if isNumScalar(vOne)	
	for ii = 1:length(v)
		vOut(ii) = fhName(v(ii));
	end
else
	for ii = 1:length(v)
	vOut(ii) = {fhName(v(ii))};
	end
end

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
