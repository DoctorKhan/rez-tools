
% function TestGaussianOne

% TestGaussianOne;
%
%
%
% Khan 06/05/2012
 
%% Default params


%% Initialize


%% Main
x0=3;
x = -x0:.1:x0;
% y = GaussianOne(x);
% ex = exp(-0.5*x0.*x0);
ex = 1 - 0.5*x0.*x0;
% ef = exp(-0.5*x.*x);
ef = 1 - 0.5*x.*x;
y = (ef - ex)./(1 - ex);
figure; plot(x,y)

% end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
