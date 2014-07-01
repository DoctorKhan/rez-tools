function sPathname = FullPathname(sPathname)

% FullPathname;
%
%
%
% Khan 06/27/2011

%% Default params


%% Initialize
sCurDir=pwd;

% cd(fileparts(sPathname))
sGivenDir=pwd; cd(sCurDir)

sDirs2Try={sCurDir, sGivenDir};

%% Main
for ii = 1:length(sDirs2Try)
    sPath2Try = fullfile(sDirs2Try{ii}, sPathname);
    if isdir(sPath2Try)
        cd(sPath2Try);
        pwd;
        cd(sGivenDir);
        break;
    elseif exist(sPath2Try, 'file');
        [p f e] = fileparts(sPathname);
        if ~isempty(p), cd(p); end
        sPathname = fullfile(pwd, [f e]);
        break;
    end
end

cd(sCurDir);
end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
