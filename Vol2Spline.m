function cmoVol2Spline = Vol2Spline(tVol)

% cmoVol2Spline = Vol2Spline(tVol);
%
% Spline finite elements of volume
%
% Khan 06/01/2012

%% Default params
Default iDim = 1
iOrder = 3;

%% Initialize
TextWaitbar(0);
iCount = 0; iN = sum(size(tVol));

%% Main
for iDim = [2 3 1]
    tVol = permute(tVol, [2 3 1]);
    viDim = size(tVol);
    
    viX = 1:size(tVol,1);
    viY = HorzVec(find(any(any(isfinite(tVol),3),1)));
    viZ = HorzVec(find(any(any(isfinite(tVol),1),2)));
    
    cmoVol2Spline = cell(1, 3);
    
    % Main loop
    for iY = viY
        for iZ = viZ
            vXVal = HorzVec(tVol(:,iY,iZ));
            vbFin = isfinite(vXVal);
            if total(vbFin) < 6, continue; end
            vX = viX(vbFin); vXVal = vXVal(vbFin);
            viXFin = viX(vbFin);
            
%             viXFin = [viXFin(1) viXFin viXFin(end)];
%             vX = [vX(1) vX vX(end)];
%             vXVal = [vXVal(1) vXVal vXVal(end)];
            
            oSpline = fastBSpline.lsqspline(viXFin, iOrder, vX', vXVal');
            
            if notDefined('moVol2Spline')
                moVol2Spline = oSpline;
                for iSpline = 1:prod(viDim(2:3))
                    moVol2Spline(iSpline) = oSpline;
                end
                moVol2Spline = reshape(moVol2Spline, viDim(2:3));
            else
                moVol2Spline(iY,iZ) = oSpline;
            end
        end
        
        cmoVol2Spline{iDim} = moVol2Spline;
        iCount = iCount + 1; TextWaitbar(iCount/iN);
    end
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
