function varargout = Foliate(mIn, func, iDim, varargin)

% varargout = Foliate(mIn, func, iDim, varargin);
%
%
%
% Khan 12/22/2011

%% Default params
Default func = @squeeze
Default iDim = 1
varargout{:} = [];
%% Arg handling
if notDefined('mIn')
    return;
end

if size(mIn,1) == 3 && size(mIn,2) ~= 3, mIn = mIn'; end

if ischar(func)
    varargin = [func varargin];
    func = @squeeze;
end

if ischar(iDim)
    varargin = [iDim varargin];
    iDim = 1;
end


%% Initialize

if islogical(mIn)
    mIn = log2sub3d(mIn);
end

mIn = HorzMat(mIn);
nRows = size(mIn,1);
%% Main
[bCell, ~, varargin] = Option('cell');

if bCell
    nArgs = nRows;
else
    nArgs = nargout;
end
%%
viDim = size(mIn);
ciSplit = num2cell(viDim);
ciSplit{iDim} = ones(1, viDim(iDim));
c = mat2cell(mIn, ciSplit{:});

for ii = 1:min([nArgs; nRows])
        v{ii} = func(c{ii}, varargin{:});
end % Function

if bCell && nargout > 0
    varargout{1} = v;
else
    for ii = 1:nargout
        try
            varargout{ii} = v{ii};
        catch
            varargout{ii} = [];
        end
    end
end
%% Note: type "doc hungarian" for variable prefix explanation.
