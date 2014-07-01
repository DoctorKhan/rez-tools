function pDir = StructDir(oStruct, varargin)

% StructDir;
%
%
%
% Khan 12/06/2011
 
%% Default params


%% Initialize
[bOnce, ~, varargin] = Option('once');

%% Main
if isstruct(oStruct)
	for csField = {'pSession', 'filename', 'sSession', 'name', 'sHemi', 'sSubject'}
		sField = csField{1};
		if isfield(oStruct(1), sField)
			pDir = fullfile(oStruct.(sField), varargin{:});
			if numel(oStruct) > 1
				pDir = {pDir};
			end
			
			return
		end
	end	
end

pDir = oStruct;

if bOnce && iscell(pDir), pDir = pDir{1}; end

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
