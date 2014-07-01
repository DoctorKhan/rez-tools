% function TestISMRM

% TestISMRM;
%
%
%
% Khan 02/22/2012

%% Default params
HemoInit

%% Initialize
pDir = '/home/khan/ISMRM2012';
csParams = {'Width', 'Peak', 'Init', 'Under', 'Hrf'};

% Main

for oHemo = voHemoAll(1:5)
cds(oHemo)
close all
FiguresHRF('BootHRFAnalysis-31D4T3C-LaminarV1pu50.mat')
end
return
%%
s = basename(SessionDir);
sCode = titleCase(s(7:end));

for ii = 1:5
figure(ii)
pause(3)
[~, s] = SplitStr(get(get(gca, 'title'), 'string'));
if ~isempty(s), sArea = s; end
sName = [sCode sArea csParams{ii} '.'];
pName = fullfile(pDir, sName);
% saveas(ii,[pName 'pdf'],'pdf')
%         saveas(ii,[pName 'emf'],'emf')
% saveas(ii,[pName 'fig'],'fig')
Str(length(dir(pDir)));
end
% end
close all
% sParam = regexp(get(get(gca, 'ylabel'), 'string'), ' ', 'split');
%%
close all
for oHemo = oRess %voHemoAll(1:5)
cds(oHemo)
FiguresHRF('BootHRFAnalysis-31D4T3C-LaminarV1pu50.mat')
for ii = 5:-1:1
pause(4)
close(ii);
end
end
close all
% end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
