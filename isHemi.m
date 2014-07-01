function b = isHemi(s)

% isHemi;
%
%
%
% Khan 02/04/2012
 
%% Default params


%% Initialize
s = StructName(s);

%% Main
b = ischar(s) && ~isempty(regexpi(s, 'Left|Right|Both'));

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
