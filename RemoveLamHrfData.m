function RemoveLamHrfData(voHemo)

% RemoveLamHrfData(voHemo);
%
% Remove old HRF data sets.
%
% Khan 06/21/2012

%% Default params
HemoInit

%% Initialize
pDir=pwd;

%% Main
for oHemo = voHemo
    cds(oHemo)
    
    voFiles = [dir('BootHRFAnalysis*.mat'); dir('lam.log')];
    [~, viSort] = sort({voFiles.date});
    voFiles = voFiles(viSort);
    iLam = CellMatch({voFiles.name}, 'lam.log');
    
    for oFile = HorzVec(voFiles(1:iLam))
        rm(oFile.name);
    end
end

cd(pDir);
end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
