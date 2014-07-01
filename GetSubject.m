function [sSubject, oHemo] = GetSubject(pDir, varargin)

% [sSubject, oHemo] = GetSubject(pDir, varargin);
%
%
%
% Khan 07/07/2011

%% Default params
% mrGlobals
Default pDir = pwd;

%% Initialize
pCurDir = pwd;
mrGlobals

%% Main
cdm(pDir);
GotoDataDir;

if GetSubjectFromDir
	sSubject = GetSubjectFromDir;
elseif exist(fullfile(pwd,'Readme.txt'), 'file')
	sSubject = regexprep(ReadParam('Readme.txt', 'Subject',':'), '\W', '');
elseif CellMatch(regexp(pwd, '/', 'split'),'HR$')
	[~, csSubjects] = CellMatch(regexp(pwd, '/', 'split'),'HR$');
	sSubject = csSubjects{1};
elseif defined('mrSESSION', 'var')
	sSubject = mrSESSION.subject;
else
	sSubject = '';
% 	Load(SessionDir('mrSESSION.mat'), 'mrSESSION.subject');
end

sSubject = regexprep(sSubject, 'HR$', '');
%% Output
sSubject = regexprep(sSubject,'HR.*','');

if nargout > 1
	HemoInit
	iSubject = CellMatch({voHemo3.sSubject}, sSubject);
	oHemo = voHemoComb(iSubject);
end

cd(pCurDir);

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
