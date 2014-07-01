function sWord = quote(sWord, sOption)

% sWord = quote(sWord);
%
%
%
% Khan 06/30/2011

%% Default params
if notDefined('sOption'), sOption = 'double'; end

%% Initialize


%% Main
switch(sOption)
    case 'single'
        sWord = ['''', sWord, ''''];
    case 'double',
        sWord = ['"', sWord, '"'];
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
