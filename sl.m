function out = sl(varargin)

if nargout > 0
	out = Ls(varargin{:});
else
	Ls(varargin{:}, '-v');
end

end % Function


%% Nosle: slype "doc hungarian" for variable prefix explanaslion.
