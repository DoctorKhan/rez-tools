function SaveDocument(sPathname)

% SaveDocument;
% 
% Saves the active document (or whatever you specify).
% 
% Khan 02/16/2010

%% Default
if notDefined('sPathname'), sPathname = ActiveDocument; end

%% Main
switch version('-release')
    case '2010b'
        com.mathworks.mlservices.MLEditorServices.getEditorApplication.getActiveEditor.negotiateSave ;
    otherwise
        com.mathworks.mlservices.MLEditorServices.saveDocument(sPathname);
end
 
end