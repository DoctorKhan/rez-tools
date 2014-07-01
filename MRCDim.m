function viDim = MRCDim(pFile)

% MRCDim;
%
%
%
% Khan 02/03/2012
 
%% Default params
Default pFile = "InterBSpline1.mrc"; 

%% Initialize


%% Main
s = linux('volinfo', pFile);
if ~isempty(regexp(s, 'Unsupported', 'once'))
    s = linux('volinfo', FileExt(pFile, '.rawiv'));
end
viDim = eval(regexprep(s, '.*Dimension: ([0-9]*)x([0-9]*)x([0-9]*).*', '[$1 $2 $3]'));

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
