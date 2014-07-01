for iROI = 1:6
    a1 =[]; a2 = [];
    for iScan = 1:10
        ts1 = meanTSeries(VOLUME{1}, iScan, iROI);
        ts = JitterCorrection(ts1, 1.5, iScan);
        %     a1 = [a1; mean(reshape(ts1,18,8)')];
        a2 = [a2; mean(reshape(ts,18,8)')];        
    end
    f{iROI} = a2;
end

b = [];
for iROI = 1:length(f)
    b = [b mean(f{iROI})'];
end
splot(b)
