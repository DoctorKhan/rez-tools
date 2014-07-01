function sPath = TryPaths(varargin)

% sPath = TryPaths(varargin);
%
% Searches for files or paths in combinations of paths.
% TryPaths({path1, path2, ...}, {file1, file2, ...});
%
% Khan 06/22/2010
% Khan 09/16/2011 - Now uses PermSet permutations

%% Default params


%% Initialize
nArgs = length(varargin);
viSetIndices = cell(1, nArgs);
for iSet = 1:nArgs
    viSetIndices{iSet} = VertVec(1:length(varargin{iSet}));
end

%% Main
mi = PermSet(viSetIndices{:});

for iRow = 1:rows(mi);
    sPath = '';
    for iCol = 1:cols(mi)
        sPath = fullfile(sPath, varargin{iCol}{mi(iRow,iCol)});
    end
    
    if isdir(sPath) || isFile(sPath) || isLink(sPath)
        % 	sPath = StructName(Ls('-d', sPath), 'once');
        % 	if ~isempty(sPath)
        break
    end
end

% sPath = '';

end % Function

%% Note: type "doc hungarian" for variable prefix explanation.
