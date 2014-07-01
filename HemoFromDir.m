function oHemo = HemoFromDir(pDir)

% oHemo = HemoFromDir;
%
%
%
% Khan 12/01/2011
 
%% Default params
Default pDir

%% Initialize
HemoInit

%% Main
if isempty(SessionFromDir(pDir))
	oHemo = eval(['o' GetSubject(pDir) ';']);
else
	oHemo = voHemoAll(CellMatch({voHemoAll.sSession},SessionFromDir));
end

for oHemi = voHemis
    if CellMatch({pwd, pDir}, oHemi.sHemi)
        oHemo.sHemi = oHemi.sHemi;
    end
end

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
