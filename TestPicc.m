% close all;
v = 1:200;
vv = repmat(v', 1, 200); 
hold off;
h = picc(vv);

hold on; plot(v, 0.01 * v.^2)