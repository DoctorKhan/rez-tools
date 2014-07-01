function tSdfFixed = FixSignsCont(tSdf0, nReps)

% tSdf = FixSignsCont(tSdf);
%
%
%
% Khan 05/28/2012

%% Default params
Default nReps = 1
Default absThresh = 2 & d2Thresh = 0.1
%% Initialize
TextWaitbar(0, 'Enforcing sign continuity...');
tSdf = tSdf0;
tSdfFixed = tSdf0;

%% Main
for iRep = 1:nReps
    oQuality = SdfQa(tSdf); % Quality check
    mBox = BoundingBox(tSdf);
    tDelSq = GradSq5p(tSdf);
    
    for iDim = 1:3
        iLowerSlice = mBox(1,iDim) + 1;
        iUpperSlice = mBox(2,iDim) - 1;

        % Permute to iterate over the next dimension.
        tSdf   = permute(tSdf, [2 3 1]);
        tDelSq = permute(tDelSq, [2 3 1]);

        for iSlice = iLowerSlice:iUpperSlice
            mN = tSdf(:,:,iSlice+1);
            mP = tSdf(:,:,iSlice-1);
            mC = tSdf(:,:,iSlice);
            mDelSq = tDelSq(:,:,iSlice);
%            if iSlice == 146
%                keyboard
%            end
            dxPosP = abs(mN - mC);
            dxNegP = abs(mC - mP);
            
            mbFix1 = tDelSq > 2; %dxPosP > 1.2 | dxNegP > 1.2; % & abs(mC) < 1;
           
%             mbFix{1} = abs(mC) < 10; absThresh;
%             mbFix{2} = abs(abs(mC + mP) - 1) < abs(abs(mC - mP) - 1);
            mbFix{2} = sign(mP) == sign(mN) & sign(mP) == -sign(mC);
%             mbFix{3} = abs(mC) < abs(mP);
            mbFix{3} = mDelSq > 0.07;
            
            mbFixAll = all(cat(4, mbFix{:}),4);
            mC(mbFixAll) = -mC(mbFixAll);
            tSdf(:,:,iSlice) = mC;

        end
    end % for
    
    TextWaitbar(iRep/nReps)

    q = SdfQa(tSdf, oQuality); % Quality check

    if q > 0
        tSdfFixed = tSdf;
    else
        TextWaitbar;
        break;
    end
        
end % for

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
