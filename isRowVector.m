function bOut = isRowVector(v)

% bOut = isRowVector(v);
% Khan  02/27/09
% Khan 11/28/2011

    viDim = size(v);
    bOut = (length(viDim) <= 2) && viDim(1) == 1;
end

%% Note: type "doc hungarian" for variable prefix explanation.
