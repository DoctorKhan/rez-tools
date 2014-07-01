function varargout = SubVol(tData, tbVol, iPadding, varargin)

% varargout = SubVol(tData, tbVol, iPadding, varargin);
%
% tSub, mBox, viLower, viUpper, viDimFull, viDim, cviRange
%
% Khan 06/11/2012

if defined('iPadding') && ischar(iPadding)
    varargin = [iPadding varargin];
    clear iPadding
end

Default iPadding = 0

%% Arg handling
if defined('tbVol')
    if ischar(tbVol)
        varargin = [tbVol varargin];
        clear tbVol;
    elseif isnumeric(tbVol) && isscalar(tbVol)
        iPadding = tbVol;
        clear tbVol;
    end
end

%% Default params
if notDefined('tbVol')
    if islogical(tData)
        tbVol = tData;
    else
        tbVol = isfinite(tData);
    end
end

%% Initialize
viDimFull = size(tbVol);
if isequal(viDimFull, [2 3])
    mBox = round(tbVol);
    viDimFull = diff(mBox) + 1;
else
    mBox = BoundingBox(tbVol);
end

if defined('iPadding') && iPadding > 0
    mBox = mBox + iPadding.*[-1 -1 -1; 1 1 1];
    mBox(mBox<1) = 1;
    vbTooBig = mBox(2,:) > viDimFull;
    mBox(2,vbTooBig) = viDimFull(vbTooBig);
end

%% Main
[cviRange viLower viUpper] = Box2Range(mBox);

tSub  = tData(cviRange{:});

viDim = size(tSub);

cviRange = {cviRange};
oSub = Struct(tSub, mBox, viLower, viUpper, viDimFull, viDim, cviRange);

%% Output
if nargout == 1
    varargout{1} = oSub;
elseif nargout > 1
    csOut = outputnames;
    nArgsIn = length(varargin);
    
    csFields = HorzVec(fieldnames(oSub));
    for iArg = 1:nargout
        if iArg > nArgsIn
            sVarOut = csOut{iArg};
            viMatches = CellMatch(csFields, sVarOut);
            sVar = csFields{viMatches(1)};
        else
            sVar = varargin{iArg};
        end
        varargout{iArg} = oSub.(sVar);
    end
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
