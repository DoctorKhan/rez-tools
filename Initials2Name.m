function sName = Initials2Name(sInitials)

% Initials2Name;
%
%
%
% Khan 05/04/2010

%% Default params


%% Initialize


%% Main
switch sInitials
    case 'rk',      sName = 'Khan';
    case 'dr',      sName = 'Ress';
    case 'dbr',     sName = 'Ress';
    case 'cg',      sName = 'Greene';
    case 'sk',      sName = 'Katyal';
    otherwise,  sName = sInitials;
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
