% function CheckDistMap(oView)

% CheckDistMap;
%
%
%
% Khan 01/04/2012
 
%% Default params


%% Initialize
Default oView = InitHidden('Volume', 'Timed', 'Norm')

%% Main
oView = MakeLayer1ROI(oView); 
x = getCurDataROI(oView, 'map', 2);
Hist(x);

% median

text(-pi/4,sin(-pi/4),'\leftarrow sin(-\pi\div4)',...
     'HorizontalAlignment','left')


 %%
 
 
% end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
