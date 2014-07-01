function vRow = rowvector(vIn)

% rowvector;
%
% Force it to be a row vector.
%
% Khan 08/11/2010

%% Default params


%% Initialize


%% Main

if iscolvector(vIn)
    vRow = vIn';
else
    vRow = vIn;
end


end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
