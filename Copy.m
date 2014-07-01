function Copy(pDestName, pSourceName, varargin)

% Copy(pDestName, pSourceName, varargin);
%
% Copy active m-file to sName2, also changing function name.
%
% Khan 06/29/2011

%% Argument handling
if notDefined('pSourceName')
        pSourceName = pDestName;
		pDestName = ActiveDocument;
end

%% Initialize
[sPath1, sName1, sExt1] = fileparts(pDestName);
[~,      sName2]        = fileparts(pSourceName);

%% Main
pTarget = fullfile(sPath1, [sName2, sExt1]);

cp(pDestName, pTarget);

linux(['sed -i -e ''s/', sName1, '/', sName2, '/g'' "', pTarget, '"']);

CloseDocument(pDestName);
edit(pTarget);

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
