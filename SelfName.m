function SelfName(varargin)

% SelfName;
%
%
%
% Khan 01/10/2012
 
%% Default params


%% Initialize

%% Main
for cxArg = varargin, sArg = cxArg{1};		
	sCom = ['for oName1234 = ' sArg ', Default(oName1234.name, oName1234); end'];
	evalin('caller', sCom);
end

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
