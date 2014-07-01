function vVals = TriScatteredEval(F, mCoords)

% TriScatteredEval;
%
%
%
% Khan 08/31/2010

%% Argument handling
viDim = size(mCoords);
if viDim(1) > viDim(2); mCoords = mCoords'; end


%% Initialize


%% Main
x = colvector(squeeze(mCoords(1,:)));
y = colvector(squeeze(mCoords(2,:)));
z = colvector(squeeze(mCoords(3,:)));

x = x(:); y = y(:); z = z(:);

vVals = F(x, y, z);

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
