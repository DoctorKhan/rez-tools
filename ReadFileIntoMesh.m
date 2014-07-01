function oMesh = ReadFileIntoMesh(pFile, varargin)

% oMesh = ReadFileIntoMesh(pFile, varargin);
%
%
%
% Khan 03/13/2012

%% Main
switch Ext(pFile)
    case '.obj'
        oMesh = ReadObjIntoMesh(pFile, varargin{:});
    case '.raw'
        oMesh = ReadRawFileIntoMesh(pFile, varargin{:});
    case '.mat'
        oMesh = readMesh(pFile, varargin{:});
    otherwise
        pObj = surf2obj(pFile);
        oMesh = ReadObjIntoMesh(pObj, varargin{:});
end

end % Function

 
%% Note: type "doc hungarian" for variable prefix explanation.
