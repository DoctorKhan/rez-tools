function eclass(sFuncLine, sDir)

% eclass(sFuncLine, sDir);
%
% Creates a new m-file from template
%
% Khan 02/12/2010

if nargin == 0, edit('ClassTemplate'); return; end
%% Default

%% Initialize
csFuncLine = regexp(sFuncLine, '[()]', 'split');
if length(csFuncLine) > 1;
    sFuncName = csFuncLine{1};
    sFuncArgs = csFuncLine{2};
    csArgs = regexp(sFuncArgs, ',', 'split');
    sArg1 = csArgs{1};
else
    sFuncArgs = 'oIn';
    sArg1 = 'oIn';
    sFuncName = sFuncLine;
end

mFilename = FileExt(sFuncName, 'm');

%% Main
% Check for existing file
if exist(mFilename, 'file') && strcmp(fparts(2, which(mFilename)), sFuncName)
    Alert(['File ', sExisting, ' already exists.'])
else
    Default sDir = "cdm";
    cdm(sDir);

    % Make it
    csText = ReadTextFile('ClassTemplate.m');
    
    csText{1} = ['% ', sFuncLine ';'];
    csText{5} = ['% ', Username, ' ', datestr(date, 23)];
    csText = regexprep(csText, 'ClassTemplate', sFuncName);
    csText = regexprep(csText, 'oFirst', sArg1);
    csText = regexprep(csText, 'oArgs', sFuncArgs);
    
    WriteTextFile(mFilename, csText);
    edit(mFilename);
end
%% clean up
cdm -;


end

%% Note: type "doc hungarian" for variable prefix explanation.
