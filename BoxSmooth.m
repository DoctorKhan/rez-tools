function smoothed = BoxSmooth(v, iWindow, nterms)

%
% smoothed = BoxSmooth(v, iWindow, nterms);
%
% Boxcar smooth a vector. Depending on 'nterms', the resultant vector will
% contain either
% 1. The original number of terms
% 2.
% 3.
%
% Khan  02/27/09
% Khan 11/28/2011 - replaced isrowvector call with colvector.

%%
if ~exist('nterms', 'var')
	nterms = 'original';
end

if ~exist('iWindow', 'var')
	iWindow = 3;
end

%%
if isvector(v)
	if any(isinf(v))
		Alert('Data to be smoothed cannot contain infinities');
		return
	end
else
	Alert('First term must be vector');
	return
end

v = colvector(v);

%% Main
l = length(v);
m = repmat(v, iWindow, 1);
m = m';
s = size(m);
cols = s(2);
rows = s(1);
a = tril(ones(cols))/0;
b=[a;m;a'];
b(isinf(b)) = [];
b=reshape(b, rows + iWindow - 1, cols);
smoothed = nanmean(b');
if strcmp(nterms,'original')
	iStart = floor((length(smoothed) - l)/2) + 1;
	iEnd = l + iStart - 1;
end
if strcmp(nterms,'maximal')
	iStart = 1;
	iEnd = length(smoothed);
end

smoothed = smoothed(iStart:iEnd);

end

%% Note: type "doc hungarian" for variable prefix explanation.
