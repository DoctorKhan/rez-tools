function b = sub2log(a, n)

% b = sub2log(a, n);
%
%
%
% Khan 07/19/2011

%% Default params


%% Initialize


%% Main
if isscalar(n)
    viDim = [1, n]; 
else 
    viDim = size(n);
end

b = false(viDim);
b(a) = true;

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
