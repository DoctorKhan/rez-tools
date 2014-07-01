function pFile = TryExt(pFile, csExts)

% pFile = TryExt(pFile, csExts);
%
% Try various extensions to find a file that exists.
%
% Khan 07/21/2011

%% Default params
if notDefined('csExts'), csExts = {'.m', '.mat', ''}; end
	
%% Main
pFile = StructName(Ls(pFile));

o = Ls(pFile);

if isscalar(o) && exist(o.name, 'file')
    pFile = o.name;
	return
else
	for oExt = Str2Struct(csExts)
		pFile = FileExtension(pFile, oExt);
		if exist(pFile, 'file')
			break;
		end
	end
end

end % Function

%% Note: type "doc hungarian" for variable prefix explanation.
