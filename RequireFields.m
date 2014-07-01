function params = RequireFields(params, csFieldnames)

%
% params = RequireFields(params, csFieldnames);
%
% Sets default values to missing field params.
%
% Khan  09/28/09
%

csMissingFields = setdiff(csFieldnames, fieldnames(params));

for ii = 1:length(csMissingFields)
    params.(csMissingFields{ii}) = GetDefault(csMissingFields{ii});
end

end
