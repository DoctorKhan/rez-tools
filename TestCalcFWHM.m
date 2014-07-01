function TestCalcFWHM

% TestCalcFWHM;
%
%
%
% Khan 01/04/2012
 
%% Default params


%% Initialize


%% Main
r = linspace(0,5,100); y = GaussianOne(r, .5, 2); figure; plot(r, y);

vXi = r; vYi = y; [~, iPeakT] = max(y);
%%
tic
[f1, h1] = CalcFWHM(vXi, vYi, iPeakT);
toc

tic
[f2, h2] = CalcFWHM2(vXi, vYi, iPeakT);
toc
end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
