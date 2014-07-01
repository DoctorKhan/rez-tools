function oStruct = Mat2Struct(mMatrix, csFields, iFieldDim)

% oStruct = Mat2Struct(mMatrix, iFieldDim, csFields);
%
%
%
% Khan 08/04/2011

%% Default params
Default csFields = "value"


%% Arg handling
% if ischar(iFieldDim)
% 	iFieldDim = strcmpi(iFieldDim, 'num');
% end

%% Initialize
Default iFieldDim = ndims(mMatrix);

%% Main
mCell = num2cell(mMatrix);
oStruct = cell2struct(mCell, csFields, iFieldDim);
if ~isscalar(oStruct)
    oStruct = InvertStruct(oStruct); 
end

% if iFieldDim, oStruct = NumStruct(oStruct); end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
