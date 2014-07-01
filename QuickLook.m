function QuickLook(sFile)

% QuickLook(sFile);
%
% Take a quick look at a mag file. Shows a movie and mean image.
% Example: mag file is P00512.7.mag
% Type:    QuickLook 512
%       or QuickLook 00512
%
% Khan 03/10/2010

%% Default params


%% Initialize
sMagfileDir = FindDataFiles('.', @CountMagFiles);
oMagfiles = dir([sMagfileDir, filesep, '*', sFile, '*.mag']); % All mag files
sMagFile=oMagfiles(1).name; % Select first match

%% Main

t4d = readMagFile(fullfile(sMagfileDir, sMagFile)); % 4d mag file matrix (X x Y x Slice x Time)
vSize = size(t4d) % Size

t = reshape(permute(t4d, [1 2 4 3]),vSize(1),vSize(2),prod(vSize(3:4))); % stack slices
t = t*256/max(t(:)); % Rescale

% Output
pic(mean(t,3)); title([sMagFile, 'Mean image']);
mplay(t);

end %function

%% Note: type "doc hungarian" for variable prefix explanation.
