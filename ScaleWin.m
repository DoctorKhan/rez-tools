function v = ScaleWin(v, scaleFac, varargin)

% ScaleWin;
%
%
%
% Khan 11/30/2011
 
%% Default params


%% Initialize
if Option('absolute')
	N = diff(v);
else
	N = 1;
end

%% Main
middle = mean(v);
vNorm = (v - middle)/N;
v = scaleFac*vNorm + middle;

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
