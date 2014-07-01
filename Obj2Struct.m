function varargout = Obj2Struct(varargin)

% oStruct = Obj2Struct(oObj);
%
%
%
% Khan 03/28/2012

%% Default params

%% Main
for ii = 1:nargin
    if ii > nargout; return; end
    oObj = varargin{ii};
    
    if isobject(oObj)
        csFields = fieldnames(oObj)';
        
        for csField = csFields, sField = csField{1};
            oStruct.(sField) = oObj.(sField);
        end
    elseif isnumeric(oObj)
        oStruct = Cell2Struct(num2cell(oObj), 'value');
    else
        oStruct = oObj;
    end
    
    varargout{ii} = oStruct;
end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
