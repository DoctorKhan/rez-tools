function csLines = str2cell(b, nCols)

% csLines = str2cell(b, nCols);
%
%
%
% Khan 06/30/2011

%% Default params
Default nCols = 1

%% Initialize


%% Main
csLines = regexp(b, '\n', 'split');
if isempty(csLines{end})
	csLines(end) = [];
end

nLines = length(csLines);
csText = cell(nLines, nCols);

if nCols > 1
    for iLine = 1:nLines
        sLine = csLines{iLine};
        csLine = SqueezeCell(regexp(sLine, ' ', 'split'));
        if ~iscell(csLine)
            csLine = {csLine};
        end
        if length(csLine) < nCols
            csLine{end+1:nCols} = [];
        end
        
        csText{iLine,1:nCols-1} = csLine{1:nCols-1};
        csText{iLine,nCols} = Str(csLine{nCols:end});
    end
    csLines = csText;
end

% vi = regexp(b, '\n');
% 
% v2=vi;
% v1=[1,vi(1:end-1)];
% 
% for ii = 1:length(v1)
% 	csLines{ii} = strtrim(b(v1(ii):v2(ii)));
% end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
