function varargout = SplitStr(sIn, sDelim, viOut)

% varargout = SplitStr(sIn, sDelim);
%
%
%
% Khan 01/15/2012
 
%% Default params
if notDefined('sDelim'), sDelim = '[ ,=]'; end

%% Initialize
varargout = cell(1, nargout);

%% Main
cs = regexp(sIn, sDelim, 'split');
Default viOut = 1:length(cs);
viOut(viOut > nargout) = [];

varargout(viOut) = cs(viOut);

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
