function tRes = Resize3(tRes, vFac, varargin)

% tRes = Resize3(tRes, vFac, varargin);
%
% Resize 3d image.
%
% Khan 06/08/2012

%% Default params

%% Initialize
if numel(vFac) > 3
    vFac = size(vFac);
else
    if isscalar(vFac)
        vFac = vFac*size(tRes);
    end
    if all(vFac == 1)
        return
    end
end

viDim = round(vFac);
n1 = numel(tRes);
n2 = prod(viDim);

%% Main
if (Option('up') && n2 < n1) || n1 == n2
    return
end

tPart = imresize(tRes, viDim([1 2]), varargin{:});
tPart = permute(tPart, [3 1 2]);

tRes = imresize(tPart, viDim([3 1]), varargin{:});
tRes = permute(tRes,   [2 3 1]);

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
