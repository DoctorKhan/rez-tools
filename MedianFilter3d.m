function t2 = MedianFilter3d(t)

% MedianFilter3d;
%
%
%
% Khan 04/20/2012
 
%% Default params


%% Initialize
% nPts = numel(t);

%% Main
tB = false(size(t));
tK = true(3,3,3); tK(14) = false;
tB(1:3,1:3,1:3) = tK;
tB = circshift(tB, [-2 -2 -2]);

vi = size(t)-1;
for ii = 2:vi(1)
    tic
    for jj = 2:vi(2)
        for kk = 2:vi(3)
            t2(ii,jj,kk) = NanMedian(t(circshift(tB, [ii jj kk])));
        end
    end
    toc
end
end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
