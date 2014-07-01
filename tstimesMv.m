function tsOut = tstimesMv(tsA, mB)

sA = size(tsA); sB = size(mB);
iNumFrames = min(sA(1),sB(1));

for it = 1:iNumFrames
    tsOut(it,:,:) = squeeze(tsA(it,:,:))*(squeeze(mB(it,:))');
end