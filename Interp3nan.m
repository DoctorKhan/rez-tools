function tOut = Interp3nan(tX, tY, tZ, tData, vX, vY, vZ, varargin)

% Interp3nan;
%
%
%
% Khan 04/01/2012
 
%% Default params


%% Initialize
vbGood = all(isfinite([vX(:) vY(:) vZ(:)]'));
vOut = nan*vbGood;

%% Main
vOut(vbGood) = LinearInterp([tX(:), tY(:), tZ(:)], tData(:), [vX(vbGood), vY(vbGood), vZ(vbGood)]);

% vOut(vbGood) = interp3(tX, tY, tZ, tData, vX(vbGood), vY(vbGood), vZ(vbGood), varargin{:});

tOut = reshape(vOut, size(vX));
end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
