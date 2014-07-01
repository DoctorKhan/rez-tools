function m2 = Dilate2D(m2, iDColor, nIter)

% m2 = Dilate2D(m2, iDColor, nIter);
% 
% 
% 
% Khan 12/09/2009

nRows = size(m2,1);
nCols = size(m2,2);

for iter = 1:nIter
    for iR = 3:nRows-2
        for iC = 3:nCols-2
            if m2(iR,iC) == iDColor
                if (m2(iR-1,iC) == 0), m2(iR-1,iC) = iDColor; end
                if (m2(iR+1,iC) == 0), m2(iR+1,iC) = iDColor; end
                if (m2(iR,iC-1) == 0), m2(iR,iC-1) = iDColor; end
                if (m2(iR,iC+1) == 0), m2(iR,iC+1) = iDColor; end
            end
        end
    end
end

end
