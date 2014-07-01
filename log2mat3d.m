function tData = log2mat3d(tbDomain, vData)

% tData = log2mat3d(tbDomain, vData);
%
%
%
% Khan 01/04/2012
 
%% Initialize
if is3d(vData)
	vData = vData(tbDomain);
end

%% Main
[mCoords, viDim] = log2sub3d(tbDomain);
tData = sub2mat3d(mCoords, vData, viDim);

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
