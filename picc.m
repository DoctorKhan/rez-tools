function hOut = picc(mImage, hIn, contrast)

% hOut = picc(mImage, hIn, contrast);
% 
% 
% 
% Khan 11/25/2009

mImage = squeeze(mImage);
vSize = size(mImage);

mImage = permute(mImage, [2 1]);



vMin = ceil(-vSize/2);
vMax = vMin + vSize;

if ~exist('hIn', 'var') || isempty(hIn)
    hOut = figure;
else
    figure(hIn);
    hOut = hIn;
end

try
    imagesc(vMin(1):vMax(1), vMin(2):vMax(2), mImage, contrast);
catch
    imagesc(vMin(1):vMax(1), vMin(2):vMax(2), mImage);
end

axis image; colormap gray;
axis(vectorize([vMin; vMax])');
set(gca,'YDir','normal')

end

