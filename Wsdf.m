function I = Wsdf(w, varargin)

% I = Wsdf(w);
%
%
%
% Khan 04/24/2012
 
%% Default params


%% Initialize
persistent v1 v2

%% Main
if notDefined('v1') || Option('reset')
    v1 = HorzVec(evalin('base', 'v1'));
    v2 = HorzVec(evalin('base', 'v2'));
    I = (1-w).*v1 + w.*v2;
else
    I = (1-w).*v1(1) + w.*v2(1);
end



end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
