function sFile = NextFile(filename)

% n = NextFile(sArgs);
%
% ls sArgs, then find next file.
%
% Khan 08/17/2011

%% Default params

%% Initialize
try filename = filename.filename; end

%% Main
[~, sBase, sExt] = fileparts(filename);
sCurr = regexp(sBase, '([0-9]*)$', 'match');
iNext = str2double(sCurr)+1;
sNext = num2str(iNext);

sBase = regexprep(sBase, '[0-9]*$', sNext);
sFile = [sBase sExt];

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
