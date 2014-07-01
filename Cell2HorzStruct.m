function varargout = Cell2HorzStruct(cFieldData, csFieldNames, varargin)

% varargout = Cell2Struct(varargin);
%
%
%
% Khan 11/07/2011

%% Default params
Default csFieldNames = "name"

%% Initialize
% cFieldData = VertVec(cFieldData);
% csFieldNames = VertVec(csFieldNames);

%% Main
voStruct = cell2struct(cFieldData, csFieldNames);
if numel(voStruct) > 1
	varargout{:} = HorzVec(NumStruct(voStruct));
else
	varargout{:} = voStruct;
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
