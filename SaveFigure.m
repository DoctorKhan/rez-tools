function SaveFigure(sFilename, handle)

% SaveFigure(sFilename, handle);
%
% Save a figure to disk.
%
% Khan 03/02/2010

%% Default params
Default handle = gcf; 
figure(handle);

if notDefined('sFilename')
%     sTitle = regexprep(get(get(gca, 'Title'), 'String'), '\W', '');
    sFilename = num2str(gcf);
end

sFilename = FileExt(sFilename, '.fig');

%% Initialize
% [~, sBaseFilename] = fileparts(sFilename);
hc = findobj(handle, 'tag', 'Colorbar');

%% Main
disp(['Saving figure to ', sFilename, '.']);
hgsave(handle, sFilename);
% print(['-f', num2str(handle)], '-r1200', '-depsc', sBaseFilename);
% print(['-f', num2str(handle)], '-r1200', '-dpng', sBaseFilename);

vYTick = get(hc, 'YTick');
mcYTickLabel = get(hc, 'YTickLabel');
vBarLim = get(hc, 'YLim');

save(FileExtension(sFilename, '.mat'), 'vYTick', 'mcYTickLabel', 'vBarLim');

disp('done.');
end %function

%% Note: type "doc hungarian" for variable prefix explanation.
