function [CurFile,varargout] = ActiveDocument

% [CurFile,varargout] = ActiveDocument;
%
% Returns active document.
%
% Khan 02/12/2010

%% Main
% Define the handle for the set of java commands:
desktopHandle=com.mathworks.mlservices.MatlabDesktopServices.getDesktop;
% Determine the last selected document in the editor:
lastDocument=desktopHandle.getLastDocumentSelectedInGroup('Editor');
% Strip off the '*' which indicates that it has been modified.
CurFile = regexprep(strtok(char(desktopHandle.getTitle(lastDocument)),'*'), '..Read Only.*', '');

% Also return the object, if requested
if nargout>1
    varargout{1}=lastDocument;
end

end %function



