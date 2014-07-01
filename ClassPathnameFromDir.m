function pPathname = ClassPathnameFromDir(pDir)

% pPathname = ClassPathnameFromDir(pDir);
%
%
%
% Khan 01/10/2012

%% Default params
Default pDir = pwd;

%% Initialize


%% Main
c = regexp(pDir, '/', 'split');

if pDir(1) == '/'
	c{1} = '/';
end

pFile2 = fullfile(c{:}, [c{end-2}, c{end}, '.Class']);
pFile1 = fullfile(c{:}, [c{end-2}(1:end-2), c{end}, '.Class']);

if exist(pFile1, 'file')
	pPathname = pFile1;
elseif exist(pFile2, 'file')
	pPathname = pFile2;
else
	pPathname = pDir;
end


end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
