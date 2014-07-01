function csOut = Inputname(vIn)

% csOut = Inputname(vIn);
%
%
%
% Khan 12/05/2011
 
%% Default params


%% Initialize

%% Main
csOut = cell(1, length(vIn));
v2 = 1:length(vIn);

for ii = v2
	csOut{ii} = evalin('caller', ['inputname(' num2str(vIn(ii)), ');']);
end

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
