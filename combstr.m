function csOut = combstr(varargin)

% csOut = combstr(varargin);
%
% All possible combinations, preserving order, from each set.
% Work in progress
%
% Khan 03/01/2010

%% Default params


%% Initialize

%% Main
for ii = 1:nargin
	csIn = varargin{ii};
	if ~iscell(csIn) csIn = {csIn};	end
	varargin{ii} = cellfun(@num2str, csIn, 'UniformOutput', false);
end

cviNumbered = cellfun(@(x)VertVec(1:length(x)), varargin, 'UniformOutput', false);

miPerm = PermSet(cviNumbered{:});

for iRow = 1:rows(miPerm);
	csOut{iRow} = '';
	for iCol = 1:cols(miPerm)
		csOut{iRow} = [csOut{iRow}, varargin{iCol}{miPerm(iRow,iCol)} ];
	end
end

end %function

%% Note: type "doc hungarian" for variable prefix explanation.
