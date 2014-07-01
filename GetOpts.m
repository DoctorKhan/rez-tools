
function GetOpts(varargin)

% GetOpts(varargin);
%
%
%
% Khan 05/15/2012
 
%% Default params


%% Initialize
csOpts = evalin('caller', 'varargin');

%% Main
for csArg = varargin, sArg = csArg{1};
    sName = ['b' TitleCase(sArg)];
    bVal = any(CellMatch(csOpts, sArg));
    assignin('caller', sName, bVal);
    if bVal
        csOpts(CellMatch(csOpts, sArg)) = [];
    end
end

assignin('caller', 'varargin', csOpts);

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
