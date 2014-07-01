function str = Capitalize(str)

% str = Capitalize(str);
% 
% Self explanatory
% 
% Khan 11/15/09

str = regexprep(regexprep(str, '(^.)', '${upper($1)}'), ...
   '(?<=\.\s*)([a-z])','${upper($1)}');
end
