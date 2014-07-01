function voStruct = Str2Struct(csIn, sField)

% voStruct = Str2Struct(csIn, sField);
%
%
%
% Khan 10/19/2011

%% Default params
if notDefined('sField'), sField = 'name'; end
if notDefined('csIn'), voStruct = []; return; end

%% Initialize
if isstruct(csIn), voStruct = csIn; return; end

if ~iscell(csIn), csIn = str2cell(csIn); end
% csIn = CellFun(@StructName, csIn);
%% Main
voStruct = HorzVec(cell2struct(HorzVec(csIn), sField));
voStruct = NumStruct(voStruct);

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
