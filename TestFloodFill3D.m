%% Sphere
N = 100;

[xx, yy, zz] = meshgrid(1:N, 1:N, 1:N);

s = size(xx);
c = [N/2 N/2 N/2]';
r = sqrt((xx - c(1)).^2 + (yy - c(2)).^2 + (zz - c(3)).^2);

tDomain = false(s);
tDomain(r < 10) = true;

mNN = CubePts(1:6)';

tForbidden = false(size(tDomain));
tForbidden(30, :, :) = true;

tic
for ii = 1:20
    tNew = circshift(tDomain, mNN(1,:)) | circshift(tDomain, mNN(2,:)) | circshift(tDomain, mNN(3,:)) ...
        | circshift(tDomain, mNN(4,:)) | circshift(tDomain, mNN(5,:)) | circshift(tDomain, mNN(6,:)) ...
        & ~tForbidden;

    tSkin = tNew  & ~tDomain;
    tDomain = tNew;
end
toc
% tBulk = tDomain;

% while total(tSkin) > 0
%     tNew = circshift(tSkin, mNN(1,:)) | circshift(tSkin, mNN(2,:)) | circshift(tSkin, mNN(3,:)) ...
%      | circshift(tSkin, mNN(4,:)) | circshift(tSkin, mNN(5,:)) | circshift(tSkin, mNN(6,:));
%     tSkin = tNew & ~tBulk;
%     tBulk = tBulk & tNew;
% end

t = tDomain + 2*tSkin;

pic(t(:,:, 50));