function pSessDir = SessionDir(varargin)

% pSessDir = SessionDir(varargin);
%
%
%
% Khan 07/15/2011
% Khan 01/11/2012 - Converted to matlab regexp.

%% Default params

%% Initialize
if nargin > 0 && (isHemo(varargin{1}) || isSession(varargin{1}))
    pIn = cds(varargin{1});
    varargin(1) = [];
else
    pIn = pwd;
end
    

%% Main
pSessHome = regexprep(pIn, '(/[0-9]{6}[a-z]{2}[^/]*)/.*', '$1');
varargin = CellFun(@Str, varargin);
if isempty(varargin)
	pSessDir = fullfile(pSessHome);
else
	pSessDir = fullfile(pSessHome, varargin{:});
end
end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
