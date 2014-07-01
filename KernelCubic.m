function [vY vX] = KernelCubic(nPts)

% KernelCubic;
%
%
%
% Khan 06/13/2012
 
%% Default params
Default nPts = 1000

%% Initialize
extent = 1.6;
x = linspace(-extent, extent, 2*nPts);

%% Main

vR = Rect(0, 1, x);
vC = conv(conv(vR,vR, 'same'),vR,'same'); 

vbRel = x>0;

vX = x(vbRel);
vX = normalize(vX);
vY = vC(vbRel);

if nargout == 0
    plot(vX, vY);
    FixFigLimits;
end

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
