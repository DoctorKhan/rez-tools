% function TriColoredPatch

% TriColoredPatch;
%
%
%
% Khan 05/03/2012
 
%% Default params


%% Initialize


%% Main
cw=ones(1,3);
% cm = [.95*cw; .9*cw; 0.9 0.9 1];
c = {0.95*cw, .8*cw, [.9 .9 1]};

% figure;
% a = colormap;
% nc = length(a); 
% cm = interp1(1:nc, a, linspace(1, nc, 1024));
% b = colormap(cm);

y = HorzVec([ylim; ylim]);
for ii = 1:3
    x = [-1 0 0 -1]+ii-1;
%     p{ii} = patch(x, y, c{ii}, 'CDataMapping', 'direct', 'FaceColor', c{ii},'EdgeColor',c{ii});
    hold on
end

% end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
