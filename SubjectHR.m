function sSubject = SubjectHR(sSubject)

% sSubject = SubjectHR(sSubject);
%
%
%
% Khan 02/05/2012
 
%% Default params


%% Initialize


%% Main
if defined('sSubject') && ~strcmp(sSubject(end-1:end), 'HR')
        sSubject = [sSubject, 'HR'];
end

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
