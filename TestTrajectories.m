% function TestTrajectories

% TestTrajectories;
%
%
%
% Khan 06/12/2012
 
%% Default params


%% Initialize


%% Main
[gx gy gz] = Grad5p(tW, 'norm');
mgt = [LinInterpC(gx, mTraj); LinInterpC(gy, mTraj); LinInterpC(gz, mTraj)];
%%

figure;
hold on;
oc = ColorMapper;

for jj = 2:10
    mTraj = squeeze(tDist(:,jj,:));
    
    quiver3s(mTraj, mTraj + mgt);
    plot3s(mTraj, 'k');
    
    
    vC = LinInterpC(tW, mTraj);
    for ii = find(isfinite(vC))
        c = oc.GetColors(vC(ii));
        
        plot3(mTraj(1,ii), mTraj(2,ii), mTraj(3,ii), 'Marker', 'o', 'MarkerFaceColor', c);
    end
end

% end % Function

%%
fastBSpline
[w p] = GetMesh(oGreene, 'Left');
cda(oGreene)
load laminae.mat

mss(d); mss(tThick); mss(d*.7); mss(tThick*.7);
%%

%% Note: type "doc hungarian" for variable prefix explanation.
