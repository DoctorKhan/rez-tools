function s = GetKey(hFig)

% s = GetKey;
%
%
%
% Khan 04/11/2012

%% Default params
Default hFig = gcf;

%% Initialize


%% Main
try
    if waitforbuttonpress
        s = get(hFig, 'CurrentCharacter');
    else
        s = '';
    end
catch
    s = 'q';
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
