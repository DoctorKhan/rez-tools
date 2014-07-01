function varargout = WhosObj(sFind, varargin)

% voObj = WhosObj(sFind, varargin);
%
%
%
% Khan 04/29/2012

%% Default params
Default sFind

%% Initialize
if isstruct(sFind)
    voVars = sFind;
    sFind = [];
else
    voVars = HorzVec(evalin('caller', 'whos'));
end

for ii = 1:length(varargin)
    sFind = [sFind '|' varargin{ii}];
end

%% Main
if nargin > 0
    viObj = CellMatch({voVars.class}, sFind);
    voObj = voVars(viObj);
else
    viNotObj = CellMatch({voVars.class}, 'struct|char|double|cell|single|logical|int');
    voVars(viNotObj) = [];
    voObj = voVars;
end

if nargout == 0
    csVars = {voObj.name};
    assignin('caller', 'csVars', csVars);
    evalin('caller', 'whos(csVars{:})');
    evalin('caller', 'clear csVars');
else
    varargout{1} = voObj;
end
end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
