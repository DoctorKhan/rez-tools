function varargout = RowsOf(m)

% varargout = RowsOf(m);
%
% takes Each row of a coordinate matrix and splits into x, y, z.
% Usage:
% [x, y, z] = RowsOf(m)
%
% Khan 04/16/2010

%% Default params


%% Initialize


%% Main

for iOut = 1:nargout
    varargout{iOut} = m(iOut,:);
end


end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
