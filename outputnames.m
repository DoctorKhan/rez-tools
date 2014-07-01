function csOut = outputnames(viArg, varargin)

% csOut = outputnames(varargin);
%
% Gives the
%
% Khan 04/14/2012

%% Default params
csOut = {};

%% Initialize
voStack = dbstack;
% nStacks = length(voStack);

%% Main
try
    [~, s] = ReadTextFile(voStack(3).file, voStack(3).line);
catch
    try
        cs = ReadTextFile(fullfile(prefdir, 'history.m'), -1);
        s = cs{1};
    catch
        warning('Cannot retreive output names from workspace.') %#ok<*WNTAG>
    end
end

cs = regexp(s, '=', 'split');
if length(cs) == 2
    csArgs = regexp(cs{1}, '\]|\[|,| ', 'split');
    csOut = SqueezeCell(csArgs);
else
    warning('Could not parse function output names.') %#ok<*WNTAG>
end

%% Output
if defined('viArg')
    nOutputs = length(csOut);
    csOut{nOutputs + 1} = '';
    
    viArg(viArg > nOutputs) = nOutputs + 1;
    
    if length(viArg) > 1
        csOut = csOut(viArg);
    else
        csOut = csOut{viArg};
    end
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
