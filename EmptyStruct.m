function oOut = EmptyStruct(oStruct)

% oOut = EmptyStruct(oStruct);
%
%
%
% Khan 03/31/2010

%% Default params


%% Initialize
csFields = fieldnames(oStruct);
nFields = length(csFields);

%% Main
for iField = 1:nFields
    sField = csFields{iField};
    oOut.(sField) = [];
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
