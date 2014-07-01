function [sOut, vUps] = SplitByCase(sWord)

% sOut = SplitByCase(sWord);
%
%
%
% Khan 08/02/2011

%% Default params
Default sOut & vUps

%% Initialize
if notDefined('sWord'), return; end

%% Main
[csMatches,vUps] = regexp(sWord, '[A-Z]', 'match');
viBad = find(~logical([1, diff(vUps,2), 1]));
vUps(viBad) = [];
csMatches(viBad) = [];
sOut = [];

vUps(end+1) = length(sWord) + 1;

if vUps(1) > 1, vUps = [1 vUps]; end

for ii = 1:length(vUps)-1
	iBeg = vUps(ii);
	
% 	if sWord(iBeg-1)
	iEnd = vUps(ii+1)-1;
	sOut = [sOut, ' ', sWord(iBeg:iEnd)];
end

% sOut(1) = [];


end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
