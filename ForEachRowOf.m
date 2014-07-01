function output = ForEachRowOf(mIn, fhFunc, cArgs, iMatPos)

% varargout = ForEachRowOf(mIn, fhFunc, cArgs, iMatPos);
%
% Calls function fhFunc on each row of mIn and returns a
% corresponding matrix. Note the order of arguments when two arguemnts are
% passed.
%
% Example: ForEachRowOf(mIn, @polyfit, )
%
% Khan 03/30/2010
% Khan 04/03/2010 - implemented varargout/varargin
% Khan 04/05/2010 - changed syntax to allow flexible argument placement

%% Defaults
% Default cArgs = {mIn}

%% Argument handling
if notDefined('iMatPos')
	iMatPos = CellMatch(cArgs, mIn);
end
if notDefined('iMatPos')
	iMatPos = CellMatch(cArgs, 'row|col');
end
if notDefined('iMatPos'), error('matrix ?'); end

%% Initialize
nOut = nargout;
nRows = size(mIn, 1);
cOut = cell(nOut, 1);

nArgs = length(cArgs);

iMatPos = iMatPos(1);

cArgs{iMatPos} =  mIn(1, :);

% if nargout > 0
[ cOut{1:nOut} ] = fhFunc(cArgs{:});

for iArgOut = 1:nOut
    if isnumeric(cOut{iArgOut})
        varargout{iArgOut} = zeros(size(cOut{iArgOut}));
    end
end
% end

%% Main

for iRow = 1:nRows
    cArgs{iMatPos} =  mIn(iRow, :);
    
    [ cOut{1:nOut} ] = fhFunc(cArgs{:});
    
    for iArgOut = 1:nOut
        if isstruct(cOut{iArgOut})
            output{iArgOut}(iRow) = cOut{iArgOut};
        else
            output{iArgOut}(iRow, :) =     cOut{iArgOut}(:);
        end
    end
    
%     TimedWaitbar(((iArgOut - 1)*nRows + iRow)/(nOut*nRows));
end

if isscalar(output) && iscell(output)
	output = output{1};
end
% TimedWaitbar;

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
