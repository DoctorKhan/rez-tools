% function CombineHemoROIsAll

% oROIs = CombineHemoROIsAll;
%
%
%
% Khan 08/14/2011

%% Default params


%% Initialize
HemoInit

%% Main
for oHemo = voHemo
	CombineHemoROIs(oHemo);
end

% end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
