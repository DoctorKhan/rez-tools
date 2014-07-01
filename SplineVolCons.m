function oSpline = SplineVolCons(oSpline, tVol)

% oSpline = SplineVolCons(oSpline, tVol);
%
%
%
% Khan 06/10/2012
 
%% Default params


%% Initialize


%% Main
if iscell(tVol)
    oSpline.cmoSpline = tVol;
elseif isObStruct(tVol)
    oSpline = CopyStruct(oSpline, tVol);
else
    oSpline = CopyStruct(oSpline, Vol2Spline(tVol));
end

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
