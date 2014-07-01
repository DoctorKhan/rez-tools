function RemoveFile

% RemoveFile;
%
%
%
% Khan 04/09/2012

%% Default params


%% Initialize


%% Main
pDoc = ActiveDocument;

if isFile(pDoc)
    Str('Removing', pDoc, '...');
    delete(pDoc)
end
if isOpen(pDoc)
    CloseDocument;
end
end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
