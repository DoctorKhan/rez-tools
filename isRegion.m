function b = isRegion(sQuery, sSubject)

% b = isRegion(sQuery, sSubject);
%
%
%
% Khan 01/25/2012

sQuery = StructName(sQuery);

%%
if strcmpi(sQuery, 'ROIs') || ~isempty(regexpi(sQuery, '_'))
    b = false;
    return
end

%% Default params
Default sSubject = "Khan";
sSubject = SubjectHR(sSubject);

%% Initialize
sQuery   = TitleCase(sQuery);

%% Main
pSubject = ExportPath('mri', 'Anatomy', sSubject);

b = exist(fullfile(pSubject, sQuery), 'dir');

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
