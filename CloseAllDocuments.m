function CloseAllDocuments

% CloseAllDocuments;
% 
% 
% 
% Khan 02/12/2010

%% Default params


%% Initialize
try
  desktop = com.mathworks.mde.desk.MLDesktop.getInstance;
    jEditor = desktop.getGroupContainer('Editor').getTopLevelAncestor;
    % we get a com.mathworks.mde.desk.MLMultipleClientFrame object
    edhandle = com.mathworks.mlservices.MLEditorServices;

%% Main
edhandle.closeAll
catch
end

end %function


