function csAllOpenEditorFiles = CurrentlyOpenFiles

% csAllOpenEditorFiles = CurrentlyOpenFiles;
% 
% Returns all currently open editor files in a cell structure
%
% Khan 02/08/2010

try
    % Matlab 7 
    % we get a com.mathworks.mde.desk.MLMultipleClientFrame object
    edhandle = com.mathworks.mlservices.MLEditorServices;
    allEditorFilenames = char(edhandle.builtinGetOpenDocumentNames);
    csAllOpenEditorFiles = cellstr(allEditorFilenames);
catch
    %     % Matlab 6
    %     % Unfortunately, we can't get the Editor handle from the Desktop
    %     handle in Matlab 6:
    %
    %     % So here's the workaround for Matlab 6:
    %     openDocs = com.mathworks.ide.editor.EditorApplication.getOpenDocuments;  % a java.util.Vector
    %     firstDoc = openDocs.elementAt(0);  % a com.mathworks.ide.editor.EditorViewContainer object
    %     jEditor = firstDoc.getParent.getParent.getParent;
    %     % we get a com.mathworks.mwt.MWTabPanel or com.mathworks.ide.desktop.DTContainer object
    csAllOpenEditorFiles = {};
end

end

%     desktop = com.mathworks.mde.desk.MLDesktop.getInstance;
%     jEditor = desktop.getGroupContainer('Editor').getTopLevelAncestor;
