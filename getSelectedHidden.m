function oView = getSelectedHidden(sViewType, sField)

% getSelectedHidden;
%
%
%
% Khan 07/24/2011

%% Default params


%% Initialize
mrGlobals

%% Main
if strcmp(sViewType, 'Volume')
    if notDefined('selectedHiddenVolume')
        InitHidden Volume selectedHiddenVolume;
        selectedHidden = selectedHiddenVolume;
    end
    
    oView = selectedHiddenVolume;
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
