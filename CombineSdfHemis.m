function CombineSdfHemis(oHemo)

% CombineSdfHemis;
%
%
%
% Khan 05/30/2012
 
%% Default params


%% Initialize
Destruct oHemo

%% Main
    for csTissue = {'White', 'Pia'}, sTissue = csTissue{1};
        pLeft = AnatPath(oHemo, 'Left', [sSubject, 'Left', sTissue, 'Sdf.rawiv']);
        pRight = AnatPath(oHemo, 'Right', [sSubject, 'Right', sTissue, 'Sdf.rawiv']);
        pBoth = AnatPath(oHemo, 'Both', [sSubject, 'Both', sTissue, 'Sdf.rawiv']);
        
        oLeft = Rawiv(pLeft);
        oRight = Rawiv(pRight);
        
        oBoth = oLeft;
        t4Both = cat(4, oLeft.tData, oRight.tData);
        
        oBoth.tData = min(t4Both, [], 4);
        oBoth.Save(pBoth);
    end

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
