function pFile = FileExt(varargin)

% pFile = FileExt(pFile, sExt);
%
% Changes the extension of a pathname to the desired one.
%
% Khan 10/28/2010

%% Default params
Default sExt

%% Initialize
bWeakly = Option('weakly');
bGreedy = Option('greedy');

sExt = varargin{end}; varargin(end) = [];
bExistingExt = CellMatch(varargin, '\..{1,5}$');

%% Arg handling
if bWeakly && bExistingExt || isempty(varargin)
    pFile = [varargin{:}];
    return
end

%% Main
if bGreedy
    sRep = '\..*$';
else
    sRep = '(\..{0,5})*$';
end

% Remove dot from desired extension.
if ~isempty(sExt) && ~any(sExt == '.'), sExt = ['.' sExt]; end

% Output
pFile = [regexprep(St(varargin{:}), sRep, '') sExt];

end % Function

%% Note: type "doc hungarian" for variable prefix explanation.