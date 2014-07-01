function oHemo = Hemo(oHemo)

% oHemo = Hemo(oHemo);
%
%
%
% Khan 06/14/2012

%% Default params


%% Initialize


%% Main
if isView(oHemo)
    oHemo = HemoFromDir(cds(oHemo.sessionCode));
elseif ischar(oHemo)
    if isFile(oHemo)
        oHemo = HemoFromDir(fileparts(oHemo));
    elseif isdir(oHemo)
        oHemo = HemoFromDir(oHemo);
    end
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
