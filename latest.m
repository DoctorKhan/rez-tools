function [pFile, pPath, sFile, sExt] = latest(sPattern)

% pFile = latest(sPattern);
%
%
%
% Khan 06/29/2011

%% Initialize
 pFile = ''; pPath = ''; sFile = ''; sExt = '';

%% Main
if defined('sPattern')
oA = dir(sPattern);
else
	oA = dir;
end

if isempty(oA), return; end

[~, ind] = max([oA.datenum]);
while oA(ind).name(1) == '.'
	oA(ind) = [];
	[~, ind] = max([oA.datenum]);
end

pFile = FullPathname(oA(ind).name);
[pPath, sFile, sExt] = fileparts(pFile);
end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
