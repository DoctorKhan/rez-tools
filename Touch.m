function Touch(pFile)
% Touch(pFile);
% Same as unix Touch command.
% Khan 05/15/2012

try
    fclose(fopen(pFile, 'w'));
catch
    error(Str('Could not open', pFile));
end
end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
