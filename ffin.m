function fractionFinite = ffin(v)

% fractionFinite = ffin(v);
%
%
%
% Khan 04/20/2012
 
%% Default params


%% Initialize


%% Main
vb = isfinite(v);
fractionFinite = sum(vb(:))./numel(v);

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
