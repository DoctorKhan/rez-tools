function t = CheckSdf(s, vWin)

% CheckSdf(s, vWin);
%
%
%
% Khan 05/29/2012

%% Default params
Default vWin = [-5 5]

%% Initialize
o = Rawiv(s);
s = o.tData;

if nargout > 0
    t = s;
end

%% Main
s(s > vWin(2)) = nan;
s(s < vWin(1)) = nan;

Slide(s);
end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
