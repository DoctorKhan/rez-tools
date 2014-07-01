function bIsUnique = isunique(vIn)

% bIsUnique = isunique(vIn);
% 
% Determine if a vector has all unique elements
% 
% Khan 02/04/2010

    bIsUnique = (length(vIn) == length(unique(vIn)));

end
