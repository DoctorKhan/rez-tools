function mOut = CubePts(vIn, varargin)

% mOut = CubePts(vIn, varargin);
%
% Get all the cube pt coordinates
%
% Khan 12/07/2009

if defined('vIn') && ~isnumeric(vIn)
    varargin = [vIn varargin];
    clear vIn;
end

mCombs = combnk([-1 -1 -1 0 0 0 1 1 1],3);
for iRow = 1:size(mCombs,1)
    mCombs = [mCombs; perms(mCombs(iRow,:))];
end

mOut = unique(mCombs,'rows');
mOut(14,:) = [];
mOut = mOut';

dsq = sum(mOut.^2);
[~, ix] = sort(dsq);
mOut = mOut(:,ix(:));

if Option('neg')
    vMean = mean(mOut);
    [~, viSort] = sort(vMean);
    mOut = mOut(:, viSort);
end

if Option('pos')
    vMean = mean(mOut);
    [~, viSort] = sort(vMean);
    mOut = -mOut(:, viSort);
end

if exist('vIn', 'var')
    mOut = mOut(:,vIn);
end

end
 
%% Note: type "doc hungarian" for variable prefix explanation.
