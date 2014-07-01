function xRms = Rms(xMatrix, iDim)

% xRms = Rms(xMatrix, iDim);
%
% 
%
% Khan 12/15/2010

%% Default params
Default iDim = 1

%% Initialize
if isvector(xMatrix)
    xMatrix = VertVec(xMatrix);
else
    xMatrix = HorzMat(xMatrix);
end

%% Main
xRms = sqrt(nanmean(xMatrix.^2, iDim));

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
