function t2 = Connect3D(t2)

% t2 = Connect3D(t2);
% 
% 
% 
% Khan 12/09/2009

c = eye(3);

for iShift = 1:3
    tm1 = circshift(t2, c(iShift,:));
    tp1 = circshift(t2, -c(iShift,:));
    tbPts2BeFilled = ((tp1 ~= 0) & (tp1 == tm1) & (t2 == 0));
    t2(tbPts2BeFilled) = tm1(tbPts2BeFilled);
end

end

