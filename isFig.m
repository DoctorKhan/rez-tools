function vbOut = isFig(varargin)

% vbOut = isFig(varargin);
%
%
%
% Khan 01/04/2012
 
%% Default params


%% Initialize
[bFirst, ~, varargin] = Option('first');

%% Main
vbOut = CellFun(@ishandle, varargin);

if bFirst
	vbOut = vbOut(1);
end

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
