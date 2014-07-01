function boolean = isMatrix(m)

% boolean = isMatrix(m);
%
%
%
% Khan  02/27/09

viSize = size(m);
viSize(viSize == 1) = [];

boolean = (length(viSize) == 2);

end %function

%% Note: type "doc hungarian" for variable prefix explanation.
