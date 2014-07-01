function bNewer = isNewer(pFileNew, pFileOld)

% bNewer = isNewer(pFileNew, pFileOld);
%
%
%
% Khan 03/08/2012
 
%% Default params


%% Initialize


%% Main
oFileNew = dir(pFileNew);
oFileOld = dir(pFileOld);

if datenum(oFileNew.date) >= datenum(oFileOld.date)
    bNewer = true;
else
    bNewer = false;
end
  

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
