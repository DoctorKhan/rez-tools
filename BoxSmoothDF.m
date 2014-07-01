function fSDFSmoothed = BoxSmoothDF(fSDF, iWindow)

%
% fSDFSmoothed = BoxSmoothDF(fSDF, iWindow);
%
% Using a boxcar smoothing algorithm to temporally smooth the even elements
% and then the odd elements of a timeseries. (The difference between even
% and odd elements can be used to compute a field map. If the input is a
% fit structure, it will apply to the timeseries contained therein.
%
% Khan  02/27/09
%

if ists(fSDF)
    tsIn = fSDF;
    s = size(tsIn);

    mTSIn = FlattenSpatialElements(tsIn);

    iMax = s(2)*s(3);


    wbProgress = waitbar(0, 'Acquiring Fit Parameters...');
    for i = 1:iMax
        waitbar((i-1)/(iMax-1), wbProgress, ['Boxcar temporal smoothing... ', num2str(i), '/', num2str(iMax)]);

        % odd elements
        mTS(1:2:s(1), i) = BoxSmooth(mTSIn(1:2:s(1), i), iWindow);
        % even elements
        mTS(2:2:s(1), i) = BoxSmooth(mTSIn(2:2:s(1), i), iWindow);

        %    for ix = 1:s(2)
        %       for iy = 1:s(3)
        %ts(:,ix,iy) = fSDF.ts(:,ix,iy);
        %          ts(1:2:s(1),ix, iy) = BoxSmooth(tsIn(1:2:s(1),ix,iy), iWindow);
        %         ts(2:2:s(1),ix, iy) = BoxSmooth(tsIn(2:2:s(1),ix,iy), iWindow);
        %    end
        %  end
    end
    fSDFSmoothed = InflateSpatialElements(mTS, s(2), s(3));
    close(wbProgress);
else
    fSDFSmoothed = DFFit(BoxSmoothDF(fSDF.ts, iWindow), fSDF.dte);
end

end