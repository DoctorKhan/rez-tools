function [viFound, csFind, csRemoved, xFound, nArgs, xVal, varargout] = Option(varargin)

% [viFound, csFind, csRemoved, xFound, nArgs, xVal, varargout] = Option(varargin);
%
% Checks if option is specified.
%
% Khan 10/14/2011

%% Init
Default xVal
bFirst = CellMatch(varargin, 'first');

if bFirst
    varargin(bFirst) = [];
end

vbCells = CellFun(@iscell, varargin);

if any(vbCells)
    csInput = [varargin{vbCells}];
else
    try
        csInput = evalin('caller', 'varargin;');
    catch
        keyboard;
    end
end

if ~iscell(csInput), csInput = {csInput}; end

csFind = varargin(~vbCells);
if ~iscell(csFind), csFind = {csFind}; end

%%
% viFound = false(size(voFind));
viFound = zeros(size(csFind));

%% Defaults
xFound = [];

%% Main
for iFind = 1:length(csFind)
    sFind = csFind{iFind};
    if isFunc(sFind)
        bFound = find(CellFun(sFind, csInput));
    else
        bFound = CellMatch(csInput, sFind);
    end
    
    if bFound
        % only saves first found item
        xFound =  csInput{bFound};
        if ischar(xFound)
            xVal = regexprep(xFound, '.*= *', '');
            if any(xFound == '=')
                if isIntStr(xVal)
                    evalin('caller', [xFound, ';']);
                else
                    evalin('caller', regexprep(xFound, xVal, [squote(xVal) ';']));
                end
            end
        end
        csFind{iFind} = xFound;
    end
    
    if isempty(bFound), bFound = 0; end
    viFound(iFind) = bFound(1);
end

csRemoved = csInput;
csRemoved(viFound(viFound>0)) = [];
nArgs = length(csRemoved);

csOut = {'viFound', 'csFind', 'csRemoved', 'xFound', 'nArgs'};
if nargin > 1
    csResult = csFind;
    for iOut = 1:nargout
        if iOut < 7
            eval([csOut{iOut}, ' = csResult{iOut};']);
        else
            varargout{iOut-6} = csResult{iOut};
        end
    end
end

assignin('caller', 'varargin', csRemoved);

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
