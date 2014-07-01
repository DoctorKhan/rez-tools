function [oClass, mmPerVox] = GetClass(oHemo, sHemi, varargin)

% [oClass, mmPerVox] = GetClass(oHemo, sHemi);
%
% Return class file objects
%
% Khan 07/06/2010

%% Default params
Default oHemo = GetHemo;
Destruct(oHemo, 'weakly');
if notDefined('sSubject'), sSubject = GetSubject; end
if notDefined('sRegion'), sRegion = 'Cortex'; end
if notDefined('sHemi'), sHemi = 'Both'; end

%% Initialize
% Get paths
% if notDefined('sHemi')
% 	try
% 		[oClass.Left, mmPerVox] = GetClass(oHemo, 'Left');
% 	end
% 	try
% 		[oClass.Right, mmPerVox] = GetClass(oHemo, 'Right');
% 	end
% 	try
% 		[oClass.Both, mmPerVox] = GetClass(oHemo, 'Both');
%     catch
%         CombineClassFiles;
% 	end
% 	return
% end

pFile = AnatPath(sSubject, [sSubject, sHemi, '.Class']);
pFileHR = AnatPath(sSubject, [sSubject, 'HR', sHemi, '.Class']);
if ~exist(pFile, 'file') && ~isLink(pFile) && exist(pFileHR, 'file')
	cd(AnatPath(oHemo, sHemi))
	link(pFileHR, pFile);
end

%% Main
disp(['Reading class file ', pFile]);
[oClass, mmPerVox] = readClassFile(pFile);

for csField = varargin
	oClass = oClass.(csField{1});
end

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
