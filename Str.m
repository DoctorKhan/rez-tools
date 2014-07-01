function varargout = Str(varargin)

% sString = Str(varargin);
%
% Concatenates various types into string with a space or other delimiter.
%
% Khan 07/31/2011

%% Arg handling
% Passed cell of strings, rather than single set, so process each one.

%% Validation
if nargin == 0
    varargout = cell(1, nargout);
    return
end

%% Initialize
sString = '';

xE = varargin{end};

if iscell(xE)
    sDelim = xE{1};
    varargin(end) = [];
elseif isempty(xE)
    sDelim = '';
    varargin(end) = [];
else
    sDelim = ' ';
end

% varargin(cellfun(@isempty, varargin)) = [];
% nArgs = lerngth(varargin);
% sDelim = sDelim0;
% nDelim = length(sDelim);
nArgs = length(varargin);
%% Main
for iArg = 1:nArgs
    c = varargin{iArg};
    if isnumeric(c)
        try 
            if varargin{iArg+1}(1) == '%'
                c = RoundTo(c, 2); 
            end
        end
        sC = regexprep(num2str(HorzVec(c)), ' *', sDelim);
        if isLongVector(c)
            sC = ['[ ' sC ' ]'];
        end
    elseif isa(c, 'MException')
        dbstack(1)
        sC = c(end).message;
    elseif isstruct(c) || isobject(c)
        sC = StructName(c);
    elseif iscell(c)
        sC = Str(c{:}, {sDelim});
   
    else
        sC = c;
    end
    
    if isempty(c) || isempty(sString)
        sString = [sString sC];
    else
        sString = [sString sDelim sC];
    end
end

sRightChars = '.,;!%$@\)\]?}';
sLeftChars = '@\({/\[';

sString = regexprep(sString, ['[' sDelim ']([' sRightChars '])'], '$1');
sString = regexprep(sString, ['([' sLeftChars '])[' sDelim ']'], '$1');

sString = strtrim(sString);

%% Output
if nargout > 0
    varargout{:} = sString;
else
    disp(sString);
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
