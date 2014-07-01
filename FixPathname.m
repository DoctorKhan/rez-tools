function pPathname = FixPathname(pPathname)

% pName = FixPathname(pName);
%
%
%
% Khan 07/14/2011

%% Default params

if exist(pPathname), return; end


%% Initialize
[p, sName, e] = fileparts(pPathname);

pNoHR = fullfile(p, regexprep(sName, 'HR', ''), e);

%% Main
if exist(pNoHR), pName = pNoHR; end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
