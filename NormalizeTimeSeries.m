function vOut = NormalizeTimeSeries(vData)

% vOut = NormalizeTimeSeries(vData);
% 
% Normalized by total sum of the data.
% 
% Khan

vTsSize = size(vData);

vN = squeeze(sum(squeeze(sum(vData,2)),2));
mN = repmat(vN, 1, prod(vTsSize(2:end)));
vN = reshape(mN, vTsSize);
vOut = vData ./ vN;

end

%% Note: type "doc hungarian" for variable prefix explanation.
