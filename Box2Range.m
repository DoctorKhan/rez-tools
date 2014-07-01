function [cviRange viLower viUpper] = Box2Range(mBox, viUpper)

% cviRange = Box2Range(mBox);
%
%
%
% Khan 06/11/2012
 
%% Initialize
if defined('viUpper')
    mBox = [mBox; viUpper];
end

nDims = cols(mBox);
cviRange = cell(1, nDims);

%% Main
viLower = mBox(1,:);
viUpper = mBox(2,:);

for iDim = 1:nDims
    cviRange{iDim} = viLower(iDim):viUpper(iDim);
end

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
