% TestNormBall;
%
%
%
% Khan 03/16/2012
 
%% Default params
Default sPre = "Inter400s"

%% Initialize
close all

%% Main
for ii = 0:15
    pRaw = St(sPre, ii, '.raw');
    NormBall(pRaw);
end

 
%% Note: type "doc hungarian" for variable prefix explanation.
