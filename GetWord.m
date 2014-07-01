function [sWord iWord nWords] = GetWord(iWord)

% [sWord iWord nWords] = GetWord(iWord);
%
% Picks out a word from the file "vocab.txt"
%
% Khan  11/05/09
%

%% Initialize
cAllWords = textread(which('vocab.txt'), '%s');
nWords = length(cAllWords);

%% Default params
if ~exist('iWord', 'var')
    iWord = ceil(rand*nWords); % Choose random word
end

%% Main
sWord = cAllWords{iWord};

end

