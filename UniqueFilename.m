function sUnique = UniqueFilename(pFileInput)

% UniqueFilename;
%
%
%
% Khan 11/01/2010

%% Initialize


%% Main
sUnique = datestr(now, 'mmddyyyyHHMMSSFFF');
sUnique = regexprep(sUnique, '-', '');
sUnique = regexprep(sUnique, ':', '');
sUnique = regexprep(sUnique, ' ', '');

if defined('pFileInput')
    [p, f, ext] = fileparts(pFileInput);
    Default p = /tmp
    sUnique = fullfile(p, [f, sUnique,  ext]);
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
