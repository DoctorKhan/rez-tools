function [bSubject, sSubjectHR, sSubject] = isSubject(sQuery)

% [bSubject, sSubject, sSubjectHR] = isSubject(sQuery);
%
%
%
% Khan 01/25/2012
 
%% Default params
Default sQuery sSubjectHR sSubject

%% Initialize
if ~ischar(sQuery)
    bSubject = false;
    return
end

sSubject = regexprep(sQuery, 'HR$', '');
sSubjectHR = [sSubject 'HR'];

%% Main
voAll = HorzVec(dir(ExportPath('mri', 'Anatomy')));
vbDirs = [voAll.isdir];

csDirs = {voAll(vbDirs).name};
[~, csDirs] = CellMatch(csDirs, 'HR$');

viSubject = CellMatch(csDirs, ['^' sSubjectHR]);
bSubject = logical(any(viSubject>0));
end % Function

%% Note: type "doc hungarian" for variable prefix explanation.
