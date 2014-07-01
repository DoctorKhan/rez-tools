t2 = t;
nPts = length(indOuter);

vFarPt = [1e5;1e5;1e5];

for iPt = 1:nPts
    disp(num2str(iPt));

    vPt = mOuter(:,iPt);
    
    mAdjPts = CubePts' + repmat(vPt,1,26);
                
    mFilt = mOuter;
    mFilt(:, iPt) = vFarPt;

    nNear = 0;
    while nNear < 8
        tic;
        iNearest = nearpoints3d(vPt, mFilt);
        toc;
        vNearest = mFilt(:,iNearest);
        
        if sqrt(double(vNearest - vPt).^2) < 2
            nNear = nNear + 1;
            mFilt(:,iNearest) = vFarPt;
        else
            vMidPt = (vPt + vNearest)/2;
            mFilt = [mFilt,vMidPt];
            mOuter = [mOuter,vMidPt];
        end
    end

end