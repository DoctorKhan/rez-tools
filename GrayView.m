% GrayView;
%
%
%
% Khan 07/11/2011

%% Default params


%% Initialize


%% Main
if ~strcmpi(oView.viewType, 'Gray')
    oView = switch2Gray(oView); UpdateView(oView);
end

%% Note: type "doc hungarian" for variable prefix explanation.
