function b = isTissue(x)

% b = isTissue(x);
%
%
%
% Khan 06/13/2012
 
%% Default params


%% Initialize


%% Main
switch lower(x)
    case {'white', 'gray', 'pia'}
        b = true;
    otherwise
        b = false;
end

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
