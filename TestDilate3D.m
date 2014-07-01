% function TestDilate3D

% TestDilate3D;
%
%
%
% Khan 06/07/2012
 
%% Default params


%% Initialize


%% Main
f0 = SphereVolume(300, 120);
s = SphereVolume(3, 1);

f = f0; tic
for ii = 1:10
    Default h = 1;
f = imdilate(f, s);
end
toc;
%%
tic; Dilate3D(f0, 10); toc
%%
% [isl, h] = cent(f, '', '', 1);
% end % Function

tic; myDilate(f0, 10); toc; 

%% Note: type "doc hungarian" for variable prefix explanation.
