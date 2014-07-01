function s = UserEmail(sUsername, varargin)

% s = UserEmail(sUsername);
%
%
%
% Khan 03/01/2010

%% Default params
Default sUsername = Username

%% Initialize


%% Main
switch lower(sUsername)
    case 'khan'
        s = 'reswanul@gmail.com';
    case 'ress'
        s = 'ress@mail.utexas.edu';
    case 'david'
        s = 'ress@mail.utexas.edu';
    otherwise
        s = sUsername;
%         if ~Option('quiet')
%                 Str(dquote(s), 'is not in the email database.');
%                 edit UserEmail;
%         end
end


end %function


%% Note: type "doc hungarian" for variable prefix explanation.
