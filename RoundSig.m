function [vOut, sOut]  = RoundSig(vN, iDigits, varargin)

% [sOut, vOut] = RoundSig(vN, iDigits);
%
%
%
% Khan 08/16/2011

%% Default params
sOut = '';

%% Initialize

nPast = iDigits - 1;
sf2 = ['%0.' num2str(nPast) 'e'];

%% Main
for n = vN
	sn = sprintf(sf2, n);
	n2 = -str2double(regexprep(sn, '.*e', ''));
	n1 = nPast + n2;
	s1 = num2str(n1);
	sf1 = ['%0.' s1 'f'];
	s = sprintf(sf1, str2double(sn));
	s = regexprep(s, '\.0*$', '');
	sOut = [sOut ' ' s];
end

sOut = strtrim(sOut);
vOut = str2double(regexp(sOut, ' ', 'split'));

if Option('reversed|string')
	[sOut, vOut] = swap(sOut, vOut);
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
