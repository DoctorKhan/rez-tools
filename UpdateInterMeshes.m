function UpdateInterMeshes(sPre, nSurfs)

% UpdateInterMeshes(sPre, nSurfs);
%
%
%
% Khan 04/20/2012
 
%% Default params


%% Initialize


%% Main
iLast = nSurfs - 1;
pFirst = St(sPre, 0, '.rawiv');
pLast = St(sPre, iLast, '.rawiv');

for ii = 1:iLast
    pInter = St(sPre, ii, '.raw');
    
    if isNewer(pFirst, pInter) || isNewer(pLast, pInter)
        IsoMeshes(pFirst, pLast, nSurfs);
        break
    end
end

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
