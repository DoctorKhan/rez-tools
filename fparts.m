function pOut = fparts(varargin)

% pOut = fparts(varargin);
%
% Calls linux fileparts script
%
% Khan 06/30/2011

%% Default params


%% Initialize


%% Main
pOut = strtrim(linux('fileparts', varargin{:}));

if cellfind(varargin, 'HR')
	pOut = regexprep(pOut, 'HR.*', '');
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
