function mOutData = SteadyStateVsFlipAngle(fAlphaMin, fAlphaMax, fAlphaIncrement, fTR, fT1, fT2, iIterations)

%% Overloading
if ~exist('fTR', 'var')
    fTR = 0.0089 ;
end
if ~exist('fAlphaMin', 'var')
    fAlphaMin = 20*pi/180;
end
if ~exist('fAlphaMax', 'var')
    fAlphaMax = 70*pi/180;
end
if ~exist('fAlphaIncrement', 'var')
    fAlphaIncrement = 10*pi/180;
end
if ~exist('iIterations', 'var')
    iIterations = 1000;
end
if ~exist('fT2', 'var')
    fT2 = 0.099;
end
if ~exist('fT1', 'var')
    fT1 = 1.820;
end

oFlipAngleWaitBar = MyWaitbar(0, 'Please wait...' );  
%% Loop
for fAlpha = fAlphaMin:fAlphaIncrement:fAlphaMax
    fProgress = (fAlpha-fAlphaMin)/(fAlphaMax-fAlphaMin);
    MyWaitbar(fProgress, oFlipAngleWaitBar, ['Overall progress...']);
    
    mNewData = SteadyStateVsBeta(fTR, fAlpha, fT1, fT2, iIterations);
    sLegend = [num2str(fAlpha*180/pi), ' degrees'];
    
    % Create initial data point, if necessary
    if ~exist('vXData', 'var')
        vXData = mNewData(1,:);
        mYData = mNewData(2,:)';
        vLegend = [sLegend];
    else
        %acquire data
        mYData = horzcat(mYData, mNewData(2,:)');
        vLegend = vertcat(vLegend, sLegend);
    end
    %mOutData = vertcat(vXData, mYData);
    plot(vXData, mYData);
    legend(vLegend);
end

close(oFlipAngleWaitBar);

% Plot
set(gca,'XTick',-pi:pi/2:pi)
set(gca,'XTickLabel',{'-pi','-pi/2','0','pi/2','pi'})
xlabel('\beta')
ylabel('Transverse Magnetization Mxy')
title(['Mxy(Beta) with TR = ', num2str(fTR), ' s T1 = ', num2str(fT1), ' s, T2 = ', num2str(fT2), ' s'])

end
