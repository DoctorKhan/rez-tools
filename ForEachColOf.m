function mOut = ForEachColOf(mIn, fhFunc, varargin)

% varargout = ForEachColOf(mIn, fhFunc, varargin);
%
% Calls function fhFunc on each column of mIn and returns a
% corresponding matrix. Note the order of arguments when two arguemnts are
% passed.
%
% Example: ForEachColOf(mIn, @polyfit, )
%
% Khan 04/02/2010
% Khan 04/03/2010 - varargin/varargout implemented

%% Argument handling
% bSwap = isa(mIn, 'function_handle');

% if bSwap
%     [mIn, fhFunc] = swap(mIn, fhFunc);
% end

%% Initialize
% nCols = size(mIn, 2);
% nArgs = length(csArgs);
% nOutputs = nargout(fhFunc);

%% Main
mOut = ForEachRowOf(mIn', fhFunc, varargin{:})';

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
