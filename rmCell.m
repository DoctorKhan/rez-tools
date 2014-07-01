function [ c, nCells, sRegexp ] = rmCell(c, sRegexp)

% [ c, nCells, sRegexp ] = rmCell(c, sRegexp);
%
% Remove a cell according to regular expression.
%
% Khan 07/13/2011

%% Default params


%% Initialize


%% Main
nCells = numel(c);

c(cellfind(c, sRegexp)) = [];

%
if numel(c) < nCells
	nCells = numel(c);
else
	sRegexp = [];
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
