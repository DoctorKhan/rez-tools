function vTimeSeriesOut = AvgOverVolTR(cTimeSeries, iSlices, iInterleaves)
iLastIndex = floor(length(cTimeSeries.ordinate) - 1 / (iSlices*iInterleaves))*(iSlices*iInterleaves) + 1;
vTimeSeriesOut.ordinate = cTimeSeries.ordinate(1:iLastIndex);
vTimeSeriesOut.time     = cTimeSeries.time(1:iLastIndex);
end