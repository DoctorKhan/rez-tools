function s = Per(f)

% s = Per(f);
%
% Nicely formated text of percent value of fraction.
%
% Khan 04/20/2012
 
%% Default params


%% Initialize


%% Main
if f*100 <= 100.1
    f = f*100;
end
s = Str(f, '%');

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
