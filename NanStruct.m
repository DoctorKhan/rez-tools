function oOut = NanStruct(oStruct)

% oOut = NanStruct(oStruct);
%
%
%
% Khan 11/01/2011

%% Default params


%% Initialize
oStruct = oStruct(1);
csFields = fieldnames(oStruct);
nFields = length(csFields);

%% Main
for iField = 1:nFields
    sField = csFields{iField};
	if isnumeric(oStruct.(sField))
		oOut.(sField) = oStruct.(sField)*nan;
	end
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
