function h = plot3s(m, sOpt, varargin)

% h = plot3s(varargin);
%
% Same as plot3, but accepts matrix input. Nx3.
%
% Khan 07/08/2010

%% Default params
Default sOpt = "k."
try
    m = m.vertices;
end

%% Initialize
m = HorzMat(m);
iInc = ceil(length(m)/1000);
m = m(:,1:iInc:end);

[x y z] = Foliate(m, @VertVec);

%% Main
% if length(varargin) > 1
    h = plot3(x,y,z, sOpt, varargin{:});
% else
%     h = plot3(c{:});
% end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
