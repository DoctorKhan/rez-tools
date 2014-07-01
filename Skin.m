function [tbSkin, mSkin] = Skin(tDomain, iLayer)

% Skin;
%
% Skin are the domain points adjacent to a zero.
%
% Khan 07/02/2010

%% Default params
Default iLayer = 0;

%% Initialize
tDomain = Dilate3D(tDomain, iLayer);		
tbBulk = tDomain & circshift(tDomain, CubePts(1)');

%% Main

for iRow = 2:6
    tbBulk = tbBulk & circshift(tDomain, CubePts(iRow)');
end

tbSkin = tDomain & ~tbBulk;

if nargout == 2
    mSkin = log2sub3d(tbSkin);
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
