function s = Percent(f, d, varargin)

% s = Percent(f);
%
% Nicely formatted percent text of fraction or fraction of logical matrix f.
%
% Khan 04/20/2012

%% Default params


%% Initialize
if nargin > 1
    n = f;
    f = n / d;
end

%% Main
if islogical(f)
    f = frac(f);
end

if f < 1.01
    f = 100*f;
end

if defined('n')
    sp = St(f, '% (', n, '/', d, ')');
else
    sp = Str(f, '%');
end

if nargout > 0
    s = sp;
else
    Str(sp, varargin{:});
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
