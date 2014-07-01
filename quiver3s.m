function quiver3s(m1, m2, varargin)

% quiver3s(m1, m2, varargin);
%
% Plots a vector from m1 to m2 in 3-space.
%
% Khan 07/08/2010close all


%% Default params


%% Initialize
if isstruct(m1)
    m2 = m1.vertexnormals;
    m1 = m1.vertices;
end

m1 = VertMat(m1);
m2 = VertMat(m2);

%% Main
m2 = m2 - m1;
[x y z] = Foliate(m1);
[u v w] = Foliate(m2);

quiver3(x,y,z,u,v,w,varargin{:});

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
