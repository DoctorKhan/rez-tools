function mv(pSrc, pDest, varargin)

% mv(varargin);
%
% Khan 10/14/2011

%% Main
[bForce, ~, varargin] = Option('f|force');
pDest = St(pDest, varargin{:});

if bForce
    movefile(pSrc, pDest, 'f');
else
    movefile(pSrc, pDest);
end

end

%% Note: type "doc hungarian" for variable prefix explanation.
