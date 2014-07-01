% TransSpatGradIp2Vol;
%
%
%
% Khan 07/11/2011

%% Default params


%% Initialize


%% Main
inplane=checkSelectedInplane; VOLUME{1}=ip2volSpatialGradient(inplane,VOLUME{1});

%% Note: type "doc hungarian" for variable prefix explanation.
