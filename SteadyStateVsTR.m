function mOutData = SteadyStateVsTR(fAlpha, fT1, fT2, iIterations, fTRMin, fTRMax, fTRIncrement)

%% Overloading
if ~exist('fAlpha', 'var')
    fAlpha = pi/3 ;
end
if ~exist('fTRMin', 'var')
    fTRMin = 0.01;
end
if ~exist('fTRMax', 'var')
    fTRMax = .2;
end
if ~exist('fTRIncrement', 'var')
    fTRIncrement = 0.01;
end
if ~exist('iIterations', 'var')
    iIterations = 100;
end
if ~exist('fT2', 'var')
    fT2 = .099;
end
if ~exist('fT1', 'var')
    fT1 = 1.82;
end

%% Loop
for fTR = fTRMin:fTRIncrement:fTRMax
    % Create initial data point, if necessary
    if ~exist('mData', 'var')
        mData = SteadyStateVsBeta(fTR, fAlpha, fT1, fT2, iIterations);
        vXData = mData(1,:);
        mYData = mData(2,:);
    else
        %acquire data
        mData = SteadyStateVsBeta(fTR, fAlpha, fT1, fT2, iIterations);
        mYData = vertcat(mYData, mData(2,:));
    end

end

mOutData = vertcat(vXData, mYData);
% Plot
plot(vXData, mYData);
set(gca,'XTick',-pi:pi/2:pi)
set(gca,'XTickLabel',{'-pi','-pi/2','0','pi/2','pi'})
xlabel('\beta')
ylabel('Transverse Magnetization M_y')
title('Variation of TR and Beta with T1 = 1 s, T2 = 0.1 s')

end
