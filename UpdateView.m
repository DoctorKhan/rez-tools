function UpdateView(oView)

% UpdateView(oView);
%
%
%
% Khan 07/13/2011

%% Default params


%% Initialize
mrGlobals

%% Main
% evalin('caller', [oView.name, ' = ', inputname(1), ';' ]);
if ~isView(oView, 'Hidden')
	evalin('caller', [inputname(1), ' = refreshScreen(', inputname(1), ');']);
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
