function oView = SliceMeshFromMenu(oView)

% oView = SliceMeshFromMenu(oView);
%
%
%
% Khan 06/04/2012

%% Default params
csDefaultAnswer = {'0.5'};

%% Initialize
csPrompt = {'Mesh thickness (voxels)'};

%% Main
if ~isSub(oView.ui, 'meshOverlay') || ~isSub(oView.ui.meshOverlay, 'bShow', true)
    csResponse = inputdlg(csPrompt, 'Mesh selection...', 1, csDefaultAnswer);
    
    if(~isempty(csResponse))
        %     viMesh = str2double(regexp(csResponse{1}, '[0-9]*', 'match'));
        sliceThick = str2double(csResponse{1});
    end
    oView = SliceMeshVista(oView, sliceThick);
    oView.ui.meshOverlay.bShow = true;
else
    oView.ui.meshOverlay.bShow = false;
    oView = refreshView(oView);
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
