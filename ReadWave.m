function [wave, fullwave] = ReadWave(sName)
try
    fullwave = dlmread(sName);
catch
    fullwave = dlmread(['/projects/ress/mri/SSFP/SSFP/', sName]);
end
    wave = fullwave(:, 2);
end