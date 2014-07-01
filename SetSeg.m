function SetSeg(sRegion)

% SetSeg;
%
%
%
% Khan 01/23/2012
 
%% Default params
Default sRegion = "Cortex";

%% Initialize
sSubject = [GetSubject 'HR'];

pSession = SessionDir('mrSESSION.mat');
pROIs1 = AnatPath(sSubject, 'ROIs');
pROIs2 = AnatPath(sSubject, sRegion, 'ROIs');

pAnat1 = AnatPath(sSubject, 'vAnatomy.dat');
pAnat2 = AnatPath(sSubject, sRegion, 'vAnatomy.dat');

%% Main
load(pSession);
mrSESSION.segmentation = sRegion;
Save(pSession, mrSESSION, dataTYPES); 

if ~exist(pROIs2, 'file') && exist(pROIs1, 'file')
	copyfile(pROIs1, pROIs2);
end

if ~exist(pAnat2, 'file') && exist(pAnat1, 'file')
	copyfile(pAnat1, pAnat2);
end

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
