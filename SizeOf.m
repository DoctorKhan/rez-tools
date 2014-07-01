function iSize = SizeOf(sVar)

% iSize = SizeOf(sVar);
%
%
%
% Khan 08/17/2011

%% Default params


%% Initialize
if ~ischar(sVar)
	sVar = inputname(1);
end

%% Main
oInfo = evalin('caller', ['whos(' squote(sVar) ');']);
iSize = oInfo.bytes;

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
