function bCol = iscolvector(v)

% bCol = iscolvector(v);
%
% See also: colvector, isrowvector 
% Khan  02/27/09
% Khan 11/28/2011

	bCol = isvector(v) && size(v, 2) == 1;
end

%% Note: type "doc hungarian" for variable prefix explanation.
