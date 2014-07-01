function Save(pLoc, varargin)

% Save(pLoc, varargin);
%
% This avoids the red underlines on variables when using save command.
%
% Khan 07/20/2011

%% Default params
if nargin == 1
	varargin{1} = inputname(1);
end

Default sAppend

%% Initialize
pLoc = StructName(pLoc);

if Option('append') || Option('-append')
	sAppend = '-append';
end

pLoc = FileExt(pLoc, 'mat');
nArgs = length(varargin);

%% Main
[~, ~] = mkdir(fileparts(pLoc));
csInputNames = Inputname(2:nArgs+1);
sInputNames = Str(csInputNames{:});

sSave = St('save ', pLoc, ' ', sInputNames, ' -v7.3 ', sAppend);
evalin('caller', sSave);
Str('Saved', sInputNames, 'in', pLoc);

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
