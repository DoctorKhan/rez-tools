function varargout = SampleCoords

% SampleCoords;
%
%
%
% Khan 07/27/2011

%% Default params
% Default nDims = nargout

%% Initialize


%% Main
x = linspace(-1,1,100);
y = 1-x.^2;

switch nargout
	case 1
		varargout = {x};
	case 2
		varargout = {x, y};
	case 3
		m = reshape(SampleTS, 3, []);
		varargout = {m(1,:), m(2,:), m(3,:)};
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
