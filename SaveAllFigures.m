function SaveAllFigures

% SaveAllFigures;
%
%
%
% Khan 02/24/2012
 
%% Default params


%% Initialize
vhFigures = findobj('Type', 'figure');

%% Main
for hFig = HorzVec(vhFigures)
    figure(hFig);
    SaveFigure;
    close(hFig);
end

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
