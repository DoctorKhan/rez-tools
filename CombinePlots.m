function CombinePlots(vHandles)

% Supposed to combine separate plots into the subplots of one figure, but
% doesn't work. - Rez

%vHandles=setdiff(findobj( '-property', 'children', '-depth' ,2), findobj( '-property', 'children', '-depth' ,1));


% h1 = figure; plot(1:10);
% axes_handle = findobj(h1, 'Type', 'Axes')
% ach = get(axes_handle, 'Children')
% figure;
% h2 = subplot(3, 3, 1);
% ah2 = findobj(h2, 'Type', 'Axes')
% 
% copyobj(ahc, ah2);

nPlots = numel(vHandles);
iCols = ceil(sqrt(nPlots));
iRows = ceil(nPlots/iCols);

figure;

for k=1:length(vHandles)
    hsp=subplot(iRows,iCols, k);
    ax1 = axes('Parent', vHandles(k));
    copyobj(allchild(ax1), hsp)
end
drawnow
end

% figure(1);
% ax1=axes('Parent',1);
% plot(ax1,rand(100,1));
% title(ax1,'some title');
% xlabel(ax1,'time');
% ylabel(ax1,'amplitude');
% 
% figure(2);
% ax2=subplot(211);
% copyobj(allchild(ax1),ax2);