function Slide(oRawiv, oMesh, iDim, iSlice)

% Slide(t, iDim, iSlice);
%
% Show a slideshow of images.
% 'f' forward, 'p' prev, 'a' axial, 'c' coronal, 's' sagittal
% 'q' quit, 'x' close, any number: go to slice.
%
% Khan 02/25/2010

%% Arg handling
if ~isRawiv(oRawiv)
    t = oRawiv;
else
    t = oRawiv.tData;
end

%% Default params
viDim = size(t);
Default oMesh & s
viSlice = round(mean(BoundingBox(oRawiv)));

Default iDim = 1;
Default iSlice = viSlice(iDim);

%% Initialize
csNumbers = {'0','1','2','3','4','5','6','7','8','9'};
%% Main
iSlice = ShowSlide(oRawiv, oMesh, iDim, iSlice);

hFig = gcf;
while true
%     tic
    s = GetKey(hFig);
    dt = 8; 
%     toc;
    iDeltaSlice = 1 + round(7*exp(-4*dt));
    switch s
        case {'b', 'p'}
            iSlice = iSlice - iDeltaSlice;
        case 'a'
            viSlice(iDim) = iSlice;
            iDim = 2;iSlice = viSlice(iDim);
        case 's'
            viSlice(iDim) = iSlice;
            iDim = 3;iSlice = viSlice(iDim);
        case 'c'
            viSlice(iDim) = iSlice;
            iDim = 1;iSlice = viSlice(iDim);
        case 'q'
            return
        case 'x'
            close(hFig);
            return
        case csNumbers
            n = '';
            while isIntStr(s)
                n = [n s];
                s = GetKey(hFig);
            end
            iSlice = str2double(n);
        otherwise
            % Next
            iSlice = iSlice + iDeltaSlice;
    end
    
    if iSlice > viDim(iDim), iSlice = 1; end
    if iSlice < 1, iSlice = viDim(iDim); end
    
    iSlice = ShowSlide(oRawiv, oMesh, iDim, iSlice);
end % while

end % function

function iSlice = ShowSlide(oRawiv, oMesh, iDim, iSlice)
persistent hFig
Default hFig = figure;

if defined('oMesh')
    iSlice = SliceMeshOnVolume(oMesh, oRawiv, iDim, iSlice);
else
    [iSlice, hFig] = cent(oRawiv, iDim, iSlice, hFig);
end
end
%% Note: type "doc hungarian" for variable prefix explanation.
