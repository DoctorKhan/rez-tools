function xA = ExpandDims(xA, xB)

% xA = ExpandDims(xA, xB);
%
%
%
% Khan 05/15/2012
 
%% Default params


%% Initialize
viDimA = size(xA); viDimB = size(xB);
nDimsA = length(viDimA); nDimsB = length(viDimB);

%% Main
ciDimB = num2cell(viDimB);
for iDimA = viDimA
    for iDim = 1:nDimsB
        if ciDimB{iDim} == iDimA
            ciDimB{iDim} = [];
            break;
        end
    end
end

xA = repmat(xA, [ones(1,nDimsA) ciDimB{:}]);

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
