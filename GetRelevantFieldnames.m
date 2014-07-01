function cFieldNames = GetRelevantFieldNames(s)

if iscell(s), s = s{1}; end

cFieldNames = fieldnames(s);

iMatch = strmatch('FieldName', cFieldNames);
if ~isempty(iMatch), cFieldNames{iMatch} = [];
end