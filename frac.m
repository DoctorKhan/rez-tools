function f = frac(m, mbMask)

% f = fraction(m, mbMask);
%
%
%
% Khan 09/02/2010

%% Default params


%% Initialize

%% Main
if defined('mbMask')
    f = total(m)/total(mbMask);
else
    f = total(m)/numel(m);    
end

if nargout == 0
    Str(inputname(1), '=', f*100, '%');

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
