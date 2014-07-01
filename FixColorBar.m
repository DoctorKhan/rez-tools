function FixColorBar(hFig)

% FixColorBar;
%
%
%
% Khan 04/25/2012

%% Default params
Default hFig = gcf

%% Initialize


%% Main
sFixState = get(hFig, 'UserData');
    h = colormap(gca);
    n = length(h);
    f = colorbar;
    y = get(f, 'ylim');
    set(f, 'ylim', [diff(y)/n 0] + y);
if ~strcmpi(sFixState, 'Fixed')
    
    n2 = n - 1;
    yi = interp1(linspace(1, n2, n), h, 1:n2);
    
    h(1,:) = 0.9*[1 1 1];
    h(2:end,:) = yi;
    
    colormap(h)
        
    set(hFig, 'UserData', 'Fixed');
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
