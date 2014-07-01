
% AutoMat;
%
%
%
% Khan 05/15/2012

function xC = minus(xA, xB, varargin)
if isnumeric(xA) && isnumeric(xB) && ~isscalar(xB) && ~isscalar(xA) && ~isequal(size(xA), size(xB))
    [xA, xB] = MixedMatch(xA, xB);
end

xC = builtin('minus', xA, xB, varargin{:});
end

function xC = plus(xA, xB, varargin)
if isnumeric(xA) && isnumeric(xB) && ~isscalar(xB) && ~isscalar(xA) && ~isequal(size(xA), size(xB))
    [xA, xB] = MixedMatch(xA, xB);
end

xC = builtin('plus', xA, xB, varargin{:});
end

function xC = power(xA, xB)
if isnumeric(xA) && isnumeric(xB) && ~isscalar(xB) && ~isscalar(xA) && ~isequal(size(xA), size(xB))
    [xA, xB] = MixedMatch(xA, xB);
end

xC = builtin('power', xA, xB);
end

function xC = rdivide(xA, xB, varargin)
if isnumeric(xA) && isnumeric(xB) && ~isscalar(xB) && ~isscalar(xA) && ~isequal(size(xA), size(xB))
    [xA, xB] = MixedMatch(xA, xB);
end

xC = builtin('rdivide', xA, xB, varargin{:});
end

function xC = times(xA, xB, varargin)
if isnumeric(xA) && isnumeric(xB) && ~isscalar(xB) && ~isscalar(xA) && ~isequal(size(xA), size(xB))
    [xA, xB] = MixedMatch(xA, xB);
end

xC = builtin('times', xA, xB, varargin{:});
end

%% Note: type "doc hungarian" for variable prefix explanation.
