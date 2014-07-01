function sString = squote(sString)

% sString = squote(sString);
%
%
%
% Khan 07/24/2011
% Khan 12/05/2011 - handles cell arrays of strings

%% Main
if iscell(sString)
	sString = CellFun(@squote, sString);
else
	sString = ['''', sString, ''''];
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
