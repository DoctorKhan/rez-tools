
function varargout = Destruct(oStruct, varargin)

% varargout = Destruct(oStruct, varargin);
%
% Pa
%
% Khan 08/04/2011

%% Initialize
[bWeakly, ~, varargin] = Option('weakly');
if ischar(oStruct)
    try
        oStruct = evalin('caller', [oStruct, ';']);
    end
end

%% Validation
if ~(isstruct(oStruct) || isobject(oStruct))
    try varargout{1} = oStruct; end
    return
end

%% Arg handling
if isempty(oStruct)
    if nargout > 0
        varargout{1:nargout} = [];
    end
    return
end

%% Default params
if nargout > 0
    csFieldnames = outputnames;
elseif ~isempty(varargin)
    csFieldnames = varargin;
else
    csFieldnames = fieldnames(oStruct);
end


%% Main
iArrow = CellMatch(csFieldnames, '->');
if iArrow, csFieldnames(iArrow) = []; end
nOut = length(csFieldnames);
cOut=cell(1, nOut);

for iField = 1:nOut
    try
        sField = csFieldnames{iField};
        if isLongVector(oStruct)
            cOut{iField} = {oStruct.(sField)};
        else
            cOut{iField} = oStruct.(sField);
        end
    end
end

%% Output
for iField = 1:nOut
    if bWeakly && evalin('caller', ['defined(''' csFieldnames{iField} ''')'])
        varargout{iField} = evalin('caller',  csFieldnames{iField});
    else
        if nargout == 0
            assignin('caller', csFieldnames{iField}, cOut{iField});
        else
            varargout{iField} =  cOut{iField};
        end
    end
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
