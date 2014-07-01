function m = Cell2Mat(c)

% Cell2Mat;
%
% Doesn't merge dimensions.
%
% Khan 01/06/2012
 
%% Default params


%% Initialize


%% Main
m = squeeze(cell2mat(reshape(c, 1, 1, 1, [], 1, 1, 1)));

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
