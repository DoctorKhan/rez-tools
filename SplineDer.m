function gx = SplineDer(t, iDim)

% SplineDer(t);
%
%
%
% Khan 06/01/2012
 
%% Default params
Default iDim = 1

%% Initialize
[t, oBack] = CycleFirst(t, iDim);

% [nX nY nZ] = size(t);
viX = 1:size(t,1);
iOrder = 3;

viY = HorzVec(find(any(any(isfinite(t),3),1)));
viZ = HorzVec(find(any(any(isfinite(t),1),2)));
gx = zeros(size(t));
nY = length(viY);

%% Main
for iY = viY
    for iZ = viZ
        vY = HorzVec(t(:,iY,iZ));
        
        vbFin = isfinite(vY);
        if ~any(vbFin)
            continue
        end
        vX = viX(vbFin);
        vY = vY(vbFin);
        try
            gx(:,iY,iZ) = evalAt(dx(fastBSpline.lsqspline(viX(vbFin),iOrder,vX',vY')), viX);
        catch
            keyboard
        end
    end
    TextWaitbar(iY/nY);
end

gx = CycleBack(gx, oBack);
end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
