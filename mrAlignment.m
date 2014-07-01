function mrAlignment(sSession, sOption)

% mrAlignment(sSession, sOption);
%
%
%
% Khan 07/15/2011

%% Default params
if notDefined('sOption'), sOption = ''; end

%% Initialize
if defined('sSession'), cds(sSession); end

%% Main
if strcmpi(sOption, 'new') && exist('AlignParams.mat', 'file')
    rm AlignParams.mat
end

mrAlign3

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
