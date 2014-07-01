%cd ~/mrraw
%rm *.*
%system 'scp sdc@ircepic:mrraw/* ~/mrraw/'

[gxPG, gxPGf] = ReadWave('gx.out');
%[gxRewindPG, gxRewindPGf] = ReadWave('gxRewindPG.out');
iTimeOfOrigin = 53552/4;
[m0, m1] = TrapIntegrate(gxPGf, 1, iTimeOfOrigin);

[gyPG, gyPGf] = ReadWave('gy.out');
%[gyRewindPG, gyRewindPGf] = ReadWave('gyRewindPG.out');
iTimeOfOrigin = 53552/4;
[m0y, m1y] = TrapIntegrate(gyPGf, 1, iTimeOfOrigin);

[gxRewindPG, gxRewindPGf] = ReadTrap('gxRewind');
[mr0, mr1] = TrapIntegrate(gxRewindPGf, 1, 0);

[gxRewind2PG, gxRewind2PGf] = ReadTrap('gxRewind2');
[mr20, mr21] = TrapIntegrate(gxRewind2PGf, 1, 0);
m0
mr20 + mr0

%TrapIntegrate(gxRewindPG, 1);

if (1 == 2)
    [gz2, gz2f] = ReadWave('gz2PG.out');
    [gz2a, gz2af] = ReadWave('gz2aPG.out');
    [gz2d, gz2df] = ReadWave('gz2dPG.out');

    gz2aarea = TrapIntegrate(gz2a, gz2af(1,3)/32767);
    gz2darea = TrapIntegrate(gz2d, gz2df(1,3)/32767);
    gz2area = TrapIntegrate(gz2, gz2f(1,3)/32767);
    gz2carea = gz2aarea + gz2darea + gz2area;
    floor(gz2aarea)
    floor(gz2darea)
    floor(gz2area)
    floor(gz2carea)
    [gzrf1, gzrf1f] = ReadWave('gzrf1PG.out');
    gzrf1area =TrapIntegrate(gzrf1, gzrf1f(1,3)/32767)
    %[gz4, gz4f] = ReadWave('gz4PG.out');
    %[gzRewind, gzRewindf] = ReadWave('gzRewindPG.out');
    %[gzSlabRew, gzSlabRewf] = ReadWave('gzSlabRewPG.out');
    %gzSlabRewarea = TrapIntegrate(gzSlabRew)

    %PercentChange(TrapIntegrate(gx), abs(TrapIntegrate(gxRewind)))

    %[gy, gyf] = ReadWave('gy.out');
    %[gyRewind, gyRewindf] = ReadWave('gyRewind.out');
    %PercentChange(TrapIntegrate(gy), abs(TrapIntegrate(gyRewind)))

    %[gz4, gz4f] = ReadWave('gz4.out');
    %[gzRewind, gzRewindf] = ReadWave('gzRewind.out');

    %[gzrf1, gzrf1f] = ReadWave('gzrf1.out');



    %[gzSlabRew, gzSlabRewf] = ReadWave('gzSlabRew.out');
    %[gzSlabRewa, gzSlabRewaf] = ReadWave('gzSlabRew.out');
    %[gzSlabRewd, gzSlabRewdf] = ReadWave('gzSlabRew.out');

end