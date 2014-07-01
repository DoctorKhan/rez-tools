function tb = ind2log3d(viIndices, viSize)

% tb = ind2log3d(viIndices, viSize);
% 
% Create a logical tMatrix with corresponding 1-d indices set to true.
% 
% Khan 02/04/2010

Default viSize = GetDimFromAnat
%% Argument handling
% Accept reverse argument order when unambiguous
if length(viSize) ~= 3 && length(viIndices) == 3
    [viSize viIndices] = swap(viSize, viIndices);
end

%% Main
tb = false(viSize);
tb(viIndices(isfinite(viIndices))) = true;

end
