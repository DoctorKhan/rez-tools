function tMapped = SegMap(tbVolume, nLayers2Grow)

% tMapped = SegMap(tbVolume);
%
%
%
% Khan 04/26/2012

%% Default params
Default nLayers2Grow = 5

%% Initialize
nLayers = 2;
iLayer = nLayers;
% tbNewLayer = 1;
tMapped = (nLayers+1)*ones(size(tbVolume));

tbErode = tbVolume; 
f0 = frac(tbVolume); 
f1 = f0;
tMapped(tbErode) = 0.5; 

TextWaitbar(0, 'Building erosion map...');
for ii = 1:nLayers2Grow
    tMapped(tbErode) = tMapped(tbErode) - 1;
    tbErode = Erode6f(tbErode);
    f1 = frac(tbErode);
    TextWaitbar(f0 - f1);
    if f1 <= 0, break; end
end

TextWaitbar(0, 'Building dilation map...');
tbDilated = Dilate3D(tbVolume, nLayers);
for ii = 1:nLayers2Grow
    iLayer = iLayer + 1;
    tbNewLayer = Dilate3D(tbDilated, 1, tbDilated);
    tMapped(tbNewLayer) = iLayer-0.5;
    tbDilated = tbDilated | tbNewLayer;
    
    f1 = frac(tbDilated);
    TextWaitbar(f1);
    if f1 >= 1, break; end
end

%% Main
% Inner vol
TextWaitbar(0, 'Mapping inner volume...'); 
tbInner = tbVolume & ~Dilate3D(tbVolume, -nLayers);
[~, vDistSqInner] = nearpoints3d(tbInner, Skin(~tbVolume));

% Outer vol
tbOuter = Dilate3D(tbVolume, nLayers) & ~tbVolume;
TextWaitbar(total(tbInner)/total(tbOuter | tbInner), 'Mapping outer volume...');
[~, vDistSqOuter] = nearpoints3d(tbOuter, Skin(tbVolume)); 

% Output
tMapped(tbInner) = 0.5 - sqrt(vDistSqInner);
tMapped(tbOuter) = sqrt(vDistSqOuter) - 0.5;

end % Function


%% Note: type "doc hungarian" for variable prefix explanation.
