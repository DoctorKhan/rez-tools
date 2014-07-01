function sValue = ReadParam(sFile, sParam, sDelimiter)

% ReadParam(sFile, sParam, sDelimiter);
%
%
%
% Khan 03/04/2010

%% Default params
if notDefined('sDelimiter'), sDelimiter = '='; end

%% Initialize


%% Main
try
cs = ReadTextFile(sFile);
for ii = 1:length(cs)
    if ~isempty(regexpi(cs{ii}, sParam))
               csLine = regexpi(cs{ii}, sDelimiter, 'split');
               sValue = strtrim(csLine{end});
               return
    end
end
catch
end
sValue = '';

end %function


%% Note: type "doc hungarian" for variable prefix explanation.
