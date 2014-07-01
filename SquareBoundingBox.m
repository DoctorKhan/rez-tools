function [mBB, vWidths] = SquareBoundingBox(mbMask)

% mBB = SquareBoundingBox(mbMask);
%
%
%
% Khan 02/06/2011

%% Default params


%% Initialize


%% Main
mBB = BoundingBox(mbMask);
vWidths = diff(mBB')';

vIncrease = (max(vWidths) - vWidths)./2;
mBB = round(mBB + [-vIncrease, vIncrease]);

vMaxes = size(mbMask)';
vMins = ones(2,1);

vExcess = mBB(:,2) - vMaxes;
vExcess(vExcess < 0) = 0;
mBB = mBB - [vExcess, vExcess];

vShort = vMins - mBB(:,1);
vShort(vShort < 0) = 0;
mBB = mBB + [vShort, vShort];

vWidths = diff(mBB')';


end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
