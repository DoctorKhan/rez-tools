function LegacyConvention

% LegacyConvention;
%
%
%
% Khan 07/14/2011

%% Default params


%% Initialize


%% Main
HemoInit

for oHemo = voHemo(1:4)
    sSubject = oHemo.sSubject;
    
    for csHemi = csHemis
        sHemi = csHemi{1};
        p1 = AnatPath(sSubject, 'Cortex', sHemi, [sSubject, sHemi, '.Class']);
        p2 = AnatPath(sSubject, 'Cortex', sHemi, [sSubject, 'HR', sHemi, '.Class']);
        
        if ~exist(p1), error([p1, ' not found']); break; end
        if exist(p2), rm(p2); end
        
        link(p1, p2)
    end
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
