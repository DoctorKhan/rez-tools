function sInter = StringIntersect(varargin)

% sInter = StringIntersect(varargin);
%
% Returns the characters common to all string inputs.
%
% Khan 09/23/2011

%% Default params


%% Initialize
s1 = varargin{1};

%% Main
for ii = 2:nargin
	s2 = varargin{ii};
	
	s1 = intersect(s1, s2);
end

sInter = varargin{1};
sInter = sInter(ismember(sInter, s1));


end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
