function viBad = FilterWords
[d d nWords] = GetWord;

viBad = [];

for iWord = 1:nWords
    s = Dict(GetWord(iWord));
    if ~isempty(regexpi(s, 'can be found at Merriam-WebsterUnabridged'))
        viBad = [viBad iWord];
        GetWord(iWord)
    end
end