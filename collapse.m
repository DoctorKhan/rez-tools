function mat = collapse(mat)

% collapse;
%
% reshape such that there is 1 less dimension by combining the last 2.
%
% Khan 09/01/2010

%% Default params


%% Initialize
s = size(mat);
iDims = length(s);

%% Main
switch iDims
    case 3
        mat = reshape(mat, [s(1) s(2)*s(3)]);
    case 2
        mat = mat(:);
    otherwise
end
    

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
