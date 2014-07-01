function Ste(x, varargin)

% Ste;
%
%
%
% Khan 04/24/2012
 
%% Default params


%% Initialize


%% Main
if isa(x, 'MException')
    db = dbstack;
    sErrorMessage = x(end).message;
elseif ischar(x)
    sErrorMessage = x;
else
    sErrorMessage = 'Incorrect use of Ste function';
end

sErrorMessage = Str(sErrorMessage, varargin{:});

evalin('caller', ['error(' sErrorMessage ')']);

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
