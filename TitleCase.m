function sOut = TitleCase(varargin)

% TitleCase(varargin);
%
%
%
% Khan 12/15/2011
 
%% Default params
%% Initialize

%% Main
if all(CellFun(@ischar, varargin));
    varargin = Capitalize(regexp(Str(varargin{:}), ' ', 'split'));
end    

sOut = Str(varargin{:});


end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
