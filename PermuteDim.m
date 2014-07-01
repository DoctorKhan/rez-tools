function m = PermuteDim(m, vPermute, iDim)

% m = PermuteDim(m, vPermute, iDim);
%
%
%
% Khan 11/09/2010

%% Default params
if notDefined('iDim'), iDim = 2; end

%% Initialize


%% Main
if iDim == 2
    m(:, :) = m(:,vPermute);
else
     m(:, :) = m(vPermute, :);
end


end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
