function SuperBar(vProgress, sText)

% SuperBar;
% 
% Shared compound waitbar. (Work in progress)
% 
% Khan 02/19/2010

%% Default params
% if notDefined('sText'), sText = ''; end

%% Initialize
global oBar;

if isempty(oBar)
    oBar.iActive = 1;
%     oBar.nBars = 1;
%     oBar.sColorScheme = 'rbgmyc';
%     oBar.csColor{1} = 'r';
%     oBar.csText{1} = sText;
    oBar.vProgress(1) = vProgress(1)/vProgress(2);
    oBar.vInc(1) = 1/vProgress(2);
    if exist('sText', 'var')
        TimedWaitbar(oBar.vProgress(1), sText);
    else
        TimedWaitbar(oBar.vProgress(1));
    end 
end

%% Main
% if ischar(progress)
%     sText = progress;
%     progress = [];
% end

if progress == 0
    % New bar
    oBar.iActive = oBar.iActive + 1;
%     if oBar.iActive <= 6
%         oBar.csColor{oBar.iActive} = oBar.sColorScheme(oBar.iActive);
%     else
%         oBar.csColor{oBar.iActive} = .8*[rand rand rand];
%     end
%     oBar.csText{oBar.iActive} = sText;
    oBar.vProgress(oBar.iActive) = progress;
    
    close(oBar.handle);
    oBar.handle = cwaitbar(oBar.vProgress, oBar.csText, oBar.csColor);
else
    oBar.vProgress(oBar.iActive) = progress;
    cwaitbar([oBar.iActive, progress]);
    
    if progress == 1
        if oBar.iActive == 1
            close(oBar.handle);
            clear oBar;
            return;
        else
            oBar.iActive = oBar.iActive - 1;
        end
    end
end

end %function
