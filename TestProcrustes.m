function TestProcrustes

% TestProcrustes;
%
% Transforms A into B using affine transformations.
%
% Khan 02/09/2012
 
%% Default params


%% Initialize
n = 10;  


%% Main
A = normrnd(0,1,[n 3]);

% S = [0.5 -sqrt(3)/2 1; sqrt(3)/2 0.5 1];
B = normrnd(0.5*A+2,0.05,n,3);
%%
[~,B2A] = procrustes(A,B);

figure; plot3s(A,'bx'); hold on;
plot3s(B,'ro');
plot3s(B2A,'rx');

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
