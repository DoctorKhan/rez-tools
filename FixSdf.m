function oRawiv = FixSdf(oRawiv, threshold, varargin)

% oRawiv = FixSdf(oRawiv, threshold, varargin);
%
%
%
% Khan 04/26/2012

%% Default params
Default threshold = Inf

%% Initialize
bIsFile = isFile(oRawiv);
oRawiv = Rawiv(oRawiv);

%% Main
fprintf('Fixing spatially inconsistent signs... '); tic
tSdf = oRawiv.tData;


% [~, hFig] = cent(tSdf);
tSdf = FixSignsFlood(tSdf); 
% cent(tSdf, '', '', hFig)
tSdf = FixSignsCont(tSdf,10); %cent(tSdf, '', '', hFig)
tSdf = MedianSignFilter3d(tSdf,5); %cent(tSdf, '', '', hFig)

disp('completed.'); toc
%% Output

tSdf(abs(tSdf)>threshold) = nan; % threshold data

oRawiv.tData = tSdf;

if bIsFile
    oRawiv.Save;
end

end % Function

%% Note: type "doc hungarian" for variable prefix explanation.
