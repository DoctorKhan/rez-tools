t = zeros(2, 3, 4);
m = zeros(2,3);
m(:) = 1:6;
t(:,:,1) = m;
t(:,:,2) = -m;
t(:,:,1) = m/2;
t(:,:,4) = m/3;


%a = Mex3DIndexing(t, 2, 1, 4)
mex Mex3DIndexing.c
pause(2)
[a, t3] = Mex3DIndexing(t, 2, 1, 4)
b= Mex3DIndexing2(t, 2, 1, 4)