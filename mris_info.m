function o = mris_info(pFile)

% o = mris_info(pFile);
%
%
%
% Khan 04/26/2012
 
%% Default params


%% Initialize


%% Main
msInfo = str2cell(linux('surf mris_info', pFile), 2);

for ii = 1:size(msInfo,1)
    sName = St(regexp(msInfo{ii,1}, '[A-Z]|[a-z]|[0-9]', 'match'));
    
    sVal = msInfo{ii,2};
    csVal = SqueezeCell(regexp(sVal, '[0-9.][0-9., ]*', 'match'));
    if ~iscell(csVal), csVal = {csVal}; end
    if ~isempty(csVal)
        try
        sVal = eval(['[' csVal{:} ']']);
        end
    end
        
    o.(sName) = sVal;
end

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
