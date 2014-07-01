function [waveOut, waveOutf] = ReadTrap(waveName)
if ~exist([waveName, 'a.out'])
    suffix = 'PG.out';
else
    suffix = '.out';
end
[wavea, waveaf] = ReadWave([waveName, 'a', suffix]);

if exist([waveName, suffix], 'file')
    [wave, wavef] = ReadWave([waveName, suffix]);
    wavea = [wavea; wave];
    waveaf = [waveaf; wavef];
end

[waved, wavedf] = ReadWave([waveName, 'd', suffix]);

waveOut = [wavea; waved];
waveOutf = [waveaf; wavedf];
end