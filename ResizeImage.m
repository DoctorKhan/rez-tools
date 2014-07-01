function ResizeImage(pNiftiRaw)

% ti16Sc = ResizeImage(pNiftiRaw);
%
%
%
% Luther 10/06/2011

%% Default params


%% Initialize
b = readFileNifti(pNiftiRaw);
hh = readAnalyzeHeader;
nSlices = size(b.data, 1);
ti16Sc = uint16(zeros(252, 314, 314));

%% Main
for ii = 1:nSlices
  TextWaitbar(ii/nSlices);
  ti16Sc(ii,:,:) = imresize(squeeze(b.data(ii,:,:)), 314/512, 'Method', 'bilinear', 'OutputSize', [314 314]); 
end

b.data = flipdim(flipdim(permute(ti16Sc, [3 2 1]), 3),1);
b.dim = hh.dim(2:4);
b.pixdim = hh.pixdim(2:4);
writeFileNifti(b);

end % Function

%% Note: type "doc hungarian" for variable prefix explanation.
