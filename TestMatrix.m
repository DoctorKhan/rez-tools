function m = TestMatrix(iTSize, iXSize, iYSize)

iCounter = 0;
for it = 1:iTSize
    for ix = 1:iXSize
        for iy = 1:iYSize
            iCounter = iCounter + 1;
            m(it,ix,iy) = iCounter;
        end
    end
end