function varargout = NumStruct(varargin)

% varargout = NumStruct(varargin);
%
% Numbers the strucure elements of an array.
%
% Khan 08/01/2011

%% Default params
% Default sNumLabel = "iNum"

%% Initialize
iArgout=0;
bBackup = CellMatch(varargin, 'backup');
nArgs = length(varargin);

%% Main
for iArg = 1:nArgs
    voStruct = Obj2Struct(varargin{iArg});

    if isstruct(voStruct)
        if iArg < nArgs && ischar(varargin{iArg+1})
            sNumLabel = varargin{iArg+1};
        else
            sNumLabel = 'iNum';
        end
        iArgout = iArgout + 1;
        varargout{iArgout} = NumStructSingle(voStruct, sNumLabel, bBackup);
    end
end

end % Function

function voStruct2 = NumStructSingle(voStruct, sNumLabel, bBackup)
if isfield(voStruct, sNumLabel) && bBackup
    voStruct = CopyField(voStruct, sNumLabel, 'iBak');
end

nTot = numel(voStruct);
for iNum = 1:nTot
    oStruct = voStruct(iNum);
    oStruct = SetSub(oStruct, iNum, sNumLabel);
    oStruct = SetSub(oStruct, nTot);
    if iNum == 1
        voStruct2 = repmat(oStruct, size(voStruct));
    end
    voStruct2(iNum) = oStruct;
end

if isLongVector(voStruct2), voStruct2 = HorzVec(voStruct2); end
end

%% Note: type "doc hungarian" for variable prefix explanation.
