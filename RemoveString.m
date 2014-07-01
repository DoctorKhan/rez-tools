function sWholeString = RemoveString(sWholeString, sSubstring)

% sWholeString = RemoveString(sWholeString, sSubstring);
% 
% Remove all instances of substring in whole string
% 
% Khan 11/17/2009

while regexpi(sWholeString, sSubstring)
    [iBeg, iEnd] = regexpi(sWholeString, sSubstring);
    sWholeString(iBeg:iEnd) = [];
end
end
