function [tbGray, mmPerVox] = GetGrayFromClass(sSubject, sRegion, sHemi)

% [tbGray, mmPerVox] = GetGrayFromClass(sSubject, sRegion, sHemi);
%
%
%
% Khan 07/08/2011

%% Default params
Default sSubject = GetSubject & sRegion = GetRegion & sHemi = GetHemi;

%% Initialize
[oClass, mmPerVox] = GetClass(sSubject, sRegion, sHemi);

%% Main
tbGray = (oClass.data ~= oClass.type.white) & (oClass.data ~= oClass.type.csf);

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
