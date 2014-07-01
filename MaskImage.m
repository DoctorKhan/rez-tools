function mImage = MaskImage(mImage, mbMask)

% mImage = MaskImage(mImage, mbMask);
%
%
%
% Khan 02/03/2011

%% Default params


%% Initialize


%% Main
mImage(~mbMask) = nan;

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
