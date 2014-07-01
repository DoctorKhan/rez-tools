function mYi = Interp1(vX, mY, vXt, varargin)

% Interp1;
%
%
%
% Khan 11/29/2011

%% Default params


%% Initialize


%% Main
if size(vX, 1) ~= size(mY,1)
		vX = permute(vX, [2 1]);
end

viBad = sum(isfinite(mY)) < 2;
mY(:,viBad) = 0;

mYi = interp1(vX, mY, vXt, varargin{:});
mYi(:,viBad) = NaN;		

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
