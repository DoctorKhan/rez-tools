function tbWhitePlusGray = FixSucharit

% tbWhitePlusGray = FixSucharit;
%
%
%
% Khan 11/04/2010 - Created

%% Default params


%% Initialize
tbGray = false([300 300 300]);
tbWhite = false(size(tbGray));

%% Main
tbGraySmall =  GetGrayFromMrGray('Katyal', 'Cortex');
tbWhiteSmall = GetWhiteFromClass('Katyal', 'Cortex');


tbGray(:,1:230,:) = tbGraySmall(:,1:230,:);
tbWhite(1:230,:,:) = tbWhiteSmall(1:230,:,:);

% cent(tbWhite + 2*tbGray);

tbWhitePlusGray = tbWhite | tbGray;

% tbWhitePlusGraySmall = 
end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
