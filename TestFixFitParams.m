% function TestFixFitParams

% TestFixFitParams;
%
%
%
% Khan 12/01/2011
 
%% Default params


%% Initialize
HemoInit

%% Main
for oHemo = voHemo
	FixFitParams(FindHemoFiles([], oHemo), oHemo);
end
	
% end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
