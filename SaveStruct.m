function SaveStruct(pSaveFile, oStruct)

% SaveStruct(pSaveFile, oStruct);
%
% Save members of struct, separately, to a mat file.
%
% Khan 09/27/2011

%% Default params


%% Initialize
pSaveFile = StructName(pSaveFile);

%% Main
csVars = fieldnames(oStruct);
Destruct(oStruct);
save(pSaveFile, csVars{:});

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
