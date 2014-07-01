function link(p1, p2, sOption)

% link(p1, p2, sOption);
%
% Make a unix link from p1 to p2.
%
% Khan 07/05/2011

%% Default params
Default sOption = "-fs";

%% Initialize
Default p2 = StripPath(p1);
if exist(p2, 'file'), delete(p2); end

%% Main
pParentDir = fileparts(p2);
if ~exist(pParentDir, 'dir')
    mkdir(pParentDir);
end

linux('ln', sOption, p1, p2);

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
