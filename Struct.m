function oStruct = Struct(varargin)

% Struct;
%
%
%
% Khan 07/24/2011

%% Default params


%% Initialize
sArgs = [squote(inputname(1)) ', ' inputname(1)];

%% Main
for iArg = 2:nargin
    sArgs = [sArgs, ', ' squote(inputname(iArg)) ', ' inputname(iArg)]; %#ok<AGROW>
end
sLine = ['struct(', sArgs, ');'];
% disp(sLine)
oStruct = evalin('caller', sLine);

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
