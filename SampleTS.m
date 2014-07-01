function [ ts, ts1, ts2, ts3 ] = SampleTS

ts1 = magic(3); ts2 = round(rand(3)*20);
ts = cat(3, ts1, ts2, -4.5*ts1, 8.9*ts2);
ts = cat(1, ts, 1.7*ts);

end