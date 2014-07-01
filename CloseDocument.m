function CloseDocument(sPathname)

% CloseDocument(sPathname);
%
% Closes the active document (or whatever document you specify).
%
% Khan 02/17/2010

%% Default
if notDefined('sPathname'), sPathname = ActiveDocument; end

%% Main
if verLessThan('matlab', '7.11')
	com.mathworks.mlservices.MLEditorServices.closeDocument(sPathname);
else
	editorservices=com.mathworks.mlservices.MLEditorServices;
	jEditorApp = editorservices.getEditorApplication;
	jEditorApp.getActiveEditor.close
	
end

end
