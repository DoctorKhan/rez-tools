function t = AccumMap(tTraj, viDim)

% AccumMap;
%
%
%
% Khan 04/19/2012
 
%% Default params
Default viDim = [300 300 300]

%% Initialize


%% Main
a = double(tTraj);
b = zeros(size(a,2), size(a,3));
tDelta = diff(a,1,3);
b(:,2:end) = squeeze(Mag(tDelta));

d = HorzVec(cumsum(b,2));
a = HorzMat(a);

ra = round(a);
[ra vb] = Finite(ra); d = Finite(d, vb);
t = accumarray(ra',d,viDim,@nanmean);
end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
