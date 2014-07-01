function bHemo = isHemo(oStruct)

% bHemo = isHemo(oStruct);
%
%
%
% Khan 01/06/2012
 
%% Default params


%% Initialize


%% Main
bHemo = isfield(oStruct, 'sSubject') && isfield(oStruct, 'sSession');

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
