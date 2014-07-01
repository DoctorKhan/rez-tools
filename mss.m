function [mm s t vMinMax] = mss(vData, iOut, varargin)

% [mm s t vMinMax] = mss(vData, iOut, varargin);
%
% Mean, Std, Sum, (remove nans);
%
% Khan 03/20/2012

%% Default params
Default iOut = 1

%% Initialize
if ischar(vData), vData = evalin('caller', [vData ';']); end
vData = VertVec(vData);
vGood = vData(isfinite(vData));

%% Main
m = mean(vGood);
s = std(vGood);
t = sum(vGood);

switch(iOut)
    case 2
        [m s] = swap(m,s);
        [s t] = swap(s, t);
    case 3
        [s t] = swap(s, t);
        [m s] = swap(m,s);
    case 4
        m = [m s t];
end

vMinMax = minmax(vData);

if nargout == 0 || ischar(iOut)
    if ischar(iOut)
        sName = iOut;
    else
        sName = inputname(1);
    end
    sPhrase = SplitByCase(sName);
    Str(sPhrase, '= (', m, '+/-', s, ')', varargin{:}, ',', Tab, 'Bounds:', vMinMax);
else
    mm = m;
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
