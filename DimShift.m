function tData = DimShift(tData, iShift)

% tData = DimShift(tData, iShift);
%
%
%
% Khan 04/30/2012
 
%% Default params


%% Initialize
nDim = ndims(tData);

%% Main
n = mod(nDim-iShift, nDim); 
tData = shiftdim(tData,n);

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
