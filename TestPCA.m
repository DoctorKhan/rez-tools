function TestPCA

% In this task we present a real life dataset in the form of a supervised classification problem.

% 50 observations, one target variable.
% What we are trying to predict here is that given these 50 metrics how likely is a user to click on a coupon.
% 
% Perform exploratory analysis on the dataset to answer following questions:
% 
% 1. Are there any redundant metrics in the 50 variables we have collected?
% 2. Are there any correlated metrics?
% 3. Will dimensionality reduction need to be applied?
% 
% Once you know what you are looking at perform the following tasks:
% 
% 1. Find the optimal number of features that maximize the accuracy of predicting 'coupon_click'
% 2. Once you identify optimal number of features can you rank the features from most important to least?
% 
% Use optimal features you found above with different classifiers and evaulate your classifiers as to how general they are with relevant metrics.

%% Default params


%% Initialize
a = ReadTextFile('coupon_clickstream.csv');

%% Main
mAll = [];
for ii = 2:length(a), eval(['mAll = [mAll; ' a{ii} '];']); end
X = mAll(:,1:end-1);
y = mAll(:,end);
%%
z = zscore(X);
c = cov(z);
[U, S, V] = svd(c);

end % Function
[31,8]
[29,14]
[25,22]
[47,34]
[41,36]

% 1. mean normalization (make the mean 0)
% 2. feature scaling (normalize by std)
% 3. compute Sigma = covariance matrix (1/m) sumonn(x.^2) = (1/m)*X'*X
% 4. compute eigenvectors of matrix sigma
% [U, S, V] = svd(covariance matrix Sigma)
% 
% z = Ux
% --
% smallest value of k for which
% sum(i,1,k, Sii)/sum(i,1,n,Sii) >= 0.99
% --
% no of princ. comp?
% choose k such that average squared projection error / squared data < 0.01
% or 99% of the variance is retained

