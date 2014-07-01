function FigDir(sGlob)

% FigDir;
%
%
%
% Khan 09/28/2011

%% Default params


%% Initialize


%% Main
for o = HorzVec(dir(sGlob)), FiguresHRF('', o); end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
