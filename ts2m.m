function m = ts2m(ts, index)
    s = size(ts);
    m = ts(index,:);
    m = reshape(m, s(2), s(3));
end