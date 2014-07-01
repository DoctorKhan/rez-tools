function Rename(pFile1, pFile2, varargin)

% Rename(pFile1, pFile2, varargin);
%
% Rename active m-file as sName2, also changing function name.
%
% Khan 06/29/2011

%% Argument handling
if notDefined('pFile2')
        pFile2 = pFile1;
		pFile1 = ActiveDocument;
end

%% Initialize
[sPath1, sName1, sExt1] = fileparts(pFile1);
[~,      sName2]        = fileparts(pFile2);

%% Main
pTarget = fullfile(sPath1, [sName2, sExt1]);

mv(pFile1, pTarget);

linux(['sed -i -e ''s/', sName1, '/', sName2, '/g'' "', pTarget, '"']);

CloseDocument(pFile1);
edit(pTarget);

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
