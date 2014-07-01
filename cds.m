function sSessionDir = cds(sSession, varargin)

% cds(sSession);
%
% Go to specified session directory.
% Example: cds 011410p
%
% Khan 02/23/2010

%% Initialize
global sLastDir;
Default sDir

if notDefined('sSession')
    sDir = pwd;
end

if ischar(sSession) && evalin('caller', ['exist(' squote(sSession) ',' squote('var') ')'])
    sSession = evalin('caller', sSession);
end

if isHemo(sSession)
    sSession = sSession.pSession;
end

if isSession(sSession)
    if exist(sSession, 'dir')
        sDir = sSession;
    else
        ccInfo = FindSession(sSession);
        if ~isempty(ccInfo)
            sDir = fileparts(ccInfo{2}{end});
            if ~isdir(sDir)
                ccInfo = FindSession(sSession, 'update');
                if length(ccInfo) < 2
                    disp('Session not found.');
                else
                    sDir = fileparts(ccInfo{2}{end});
                end
            end   
        end
    end
end

%% Main
sLastDir = pwd; % Set last dir

if nargout > 0
    sSessionDir = sDir;
elseif defined('sDir')
    cd(sDir);
end

if Option('-v')
    Str('Session:', sSession, Tab, 'Subject:', GetSubject);
end

end %function


%% Note: type "doc hungarian" for variable prefix explanation.
