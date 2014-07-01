function oC = MathOp(oA, oB, fhOp)

% oC = MathOp(oA, oB, fhOp);
%
% Perferm class math operations
%
% Khan 04/04/2012

%% Default params


%% Initialize
if isobject(oA)
    oC = eval([class(oA) '(oA)']);
else
    oC = eval([class(oB) '(oB)']);
end

csFields = fieldnames(oC)';
vbNum = CellFun(@(x) isnumeric(oC.(x)), csFields);
csFields = csFields(vbNum);

%% Main
if isempty(oA) || isempty(oB)
    dbstack
    error('Inputs empty');
end

if ~isobject(oA) && isObStruct(oB)
    x = oA; clear oA;
    for csField = fieldnames(oB)', sField = csField{1};
        oA.(sField) = x;
    end
elseif  ~isobject(oB) && isObStruct(oA);
    x = oB; clear oB;
    for csField = fieldnames(oA)', sField = csField{1};
        oA.(sField) = x;
    end
end

[oA, oB] = Obj2Struct(oA, oB);

if isequal(fhOp, @times), sOp = 'times'; end
if isequal(fhOp, @minus), sOp = 'minus'; end
if isequal(fhOp, @mtimes), sOp = 'mtimes'; end
if isequal(fhOp, @plus), sOp = 'plus'; end

for csProp = csFields, sProp = csProp{1};        
    oC.(sProp) = builtin(sOp, oA.(sProp), oB.(sProp));
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
