function finFraction = fin(A, sName)

% finFraction = Fin(A);
%
%
%
% Khan 07/22/2011
% Khan 09/05/2013 - removed try

%% Default params
if ~exist('sName', 'var') || isempty(sName), sName = inputname(1); end

%% Initialize
if isfield(A, 'vertices')
    if isfield(A, 'normals')
        A = [A.vertices; A.normals];
    else
        A = A.vertices;
    end
end

if isfield(A, 'tData'), A = A.tData; end
if isstruct(A), A = Struct2Mat(A); end

%% Main
finFraction = 100*fraction(isfinite(A));
if nargout == 0
    Str(sName, 'is', RoundTo(finFraction, 2), '% finite.');
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
