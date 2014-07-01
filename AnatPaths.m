function [csSubjects, sRegion, csHemis, csPath] = AnatPaths

% [csSubjects, sRegion, csHemis, csPath] = AnatPaths;
%
%
%
% Khan 07/08/2011

%% Default params


%% Initialize


%% Main
csSubjects = {'Greene', 'Khan', 'Ress', 'Tucker'};
csHemis = {'Left', 'Right'}; csPath = {};

for sSubject = csSubjects
    sSubject =  sSubject{1};
	for sHemi = csHemis
		sHemi =  sHemi{1};
        pPath = AnatPath(sSubject, 'Cortex', sHemi, '3DMeshes');
        if ~exist(pPath, 'dir'), error('no path'); end
		csPath = horzcat(csPath, pPath);
    end
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
