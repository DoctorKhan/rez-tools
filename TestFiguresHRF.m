% TestFiguresHRF;
%
%
%
% Khan 08/02/2011

%% Default params

HemoInit
%% Initialize
for ii = 1:100, if ishandle(ii), close(ii); end; end
oROI = V1pu50;
viSelectedBins = 8:-3:1;
%%
cds(oGreene)
FiguresHRF('*31D*V1pu*', '', '', oGreene);

%%


%% Main
for oHemo = voHemo(4)
cds(oHemo);

% Load results
FiguresHRF(oHemo, oROI);
end

%%
vo = Ls('*Boot*Laminar*Extra*');

%%
vo = Ls('Boot*Lam*V1dv*u50*');

for o = vo
	FiguresHRF(o)
end

%% Note: type "doc hungarian" for variable prefix explanation.
