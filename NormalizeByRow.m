function m = NormalizeByRow(m, iRow)

% NormalizeByRow;
%
%
%
% Khan 11/09/2010

%% Default params
if notDefined('iRow'), iRow = ceil(size(m, 1)/2); end

%% Initialize

%% Main
m = MatrixVectorDiv(m, m(iRow,:));

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
