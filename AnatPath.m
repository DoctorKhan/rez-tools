function [sPath, sSubject] = AnatPath(varargin)

% [sPath, sSubject] = AnatPath(varargin);
%
%
%
% Khan 06/26/2011

%% Default
Default sHemi

%% Initialize
[~, oHemo] = Arg2Struct(@isHemo);
oHemo.sHemi = '';

%% Main
oHemo = Arg2Struct(@isSubject, 'sSubject', oHemo);
oHemo = Arg2Struct(@isRegion,  'sRegion',  oHemo);
oHemo = Arg2Struct(@isHemi,    'sHemi',    oHemo);

Destruct(oHemo);
Default sSubject = GetSubjectHR
Default sRegion = GetRegion;

sPath = ExportPath('mri', 'Anatomy', SubjectHR(sSubject), sRegion, sHemi, varargin{:});

end % Function

%% Note: type "doc hungarian" for variable prefix explanation.