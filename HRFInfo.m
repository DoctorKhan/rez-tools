function [oInfo, pa] = HRFInfo(sField, sSession)

% oInfo = HRFInfo(sSession, sField);
%
% Find some HRF experiment parameters: period, scans, trials per scan.
%
% Khan 07/11/2011 - Created
% Khan 07/14/2011
% Khan 07/14/2011

mrGlobals;
% for ii = 1:nargin, if varargin{ii} isstruct, sSession = varargin{ii}..
%% Default params
if exist('mrSESSION.mat', 'file')
    load mrSESSION.mat
end

Default sSession = SessionDir
Default sField

%% Arg handling
if isstruct(sField), sSession = sField;  sField = ''; end
if isstruct(sSession), sSession = sSession.sessionCode; end

%% Initialize
sCurDir = pwd;
cds(sSession);
oInfo.nScans = length(mrSESSION.functionals);

%% Main
pSetup = linux('find', quote(pwd), '-name "setupParameters.m" | head -n 1');

if notDefined('pSetup')
    pSetup = linux('Extract');
    mkdir Stimulus
    mv(pSetup, 'Stimulus/');
    
    pSetup = linux('find', quote(pwd), '-name "setupParameters.m" | head -n 1');
end

if notDefined('pSetup')
    error('Couldn''t find setupParameters.m.')
end

[p, f] = fileparts(pSetup);
cdm(pSetup);

try
    eval(f);
catch
    ds.PIXPERDEG = .2; ds.t = 0; sParam = '(ds)';
    eval(['pa = ', f , sParam, ';']);
end

cd(sCurDir);
oInfo.scanPeriod = pa.period;

iTimed = cellfind({dataTYPES.name}, 'Timed');
framePeriod = dataTYPES(iTimed).scanParams(1).framePeriod;
nTrialsPerScan = dataTYPES(iTimed).blockedAnalysisParams(1).nCycles;
jitter = (pa.jitter == 1);
trialPeriod = pa.trialDuration;
nFramesPerTrial = trialPeriod/framePeriod;
nFramesPerScan = nFramesPerTrial*nTrialsPerScan;
nScans = length(mrSESSION.functionals);
period = trialPeriod;

oInfo = Struct(period, nFramesPerTrial, trialPeriod, jitter, ...
    framePeriod, nFramesPerScan, nTrialsPerScan, nScans);

if defined('sField'), oInfo = oInfo.(sField); end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
