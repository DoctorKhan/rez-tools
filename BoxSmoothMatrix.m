function smoothed = BoxSmoothMatrix(m, iWindow, nterms)

% deprecated


%% Default arguments
if ~exist('nterms', 'var')
    nterms = 'original';
end

if ~exist('iWindow', 'var')
    iWindow = 3;
end

%% Argument validation
if(ismatrix(m))
    if sum(sum(isinf(m)))
        Alert('Data to be smoothed cannot contain infinities');
        return;
    else
        Alert('First term must be matrix');
        return;
    end
end
%% main routine
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
    b';
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
