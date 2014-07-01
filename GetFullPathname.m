function sFullPathname = GetFullPathname(sPathname, sTryWhichFlag, sType)

% sFullPathname = GetFullPathname(sPathname, sTryWhichFlag);
%
% Expands a relative pathname to a full pathname. Works on both files and
% directories
%
% Khan 12/08
% Khan 02/22/2010 - updated logic

%% Initialize
% [sPath, sName, sExt] = fileparts(sPathname);
% if isempty(sExt), sExt = '.m'; end
% sPathname = fullfile(sPath, [sName, sExt]);

%% Replace '.' with current directory
if sPathname(1) == '.'
    sPathname = fullfile(pwd, sPathname(2:end));
end

if defined('sType') && exist(fullfile(pwd, sPathname), sType)
     sFullPathname = fullfile(pwd, sPathname);
     return
end

%% Try prepend current sPath
sGuessFullPathname = fullfile(pwd, sPathname);
if exist(sGuessFullPathname, 'dir')
    sFullPathname = sGuessFullPathname;
else
    if exist([sGuessFullPathname, '.m'], 'file')
        sFullPathname = [sGuessFullPathname, '.m'];
        return;
    end
    if defined('sType') && exist(sGuessFullPathname, sType)
        sFullPathname = sGuessFullPathname;
        return
    end
end

%% Try which
if defined('sTryWhichFlag') && ~isempty(which(sPathname))
    sFullPathname = which(sPathname);
    return;
end

%% Try uncha
if exist(sPathname)
    sFullPathname = sPathname;
    [p, f, sExt] = fileparts(sFullPathname);
    if ~exist(sFullPathname, 'dir') && exist([sFullPathname, '.m'], 'file')
        sFullPathname = [sFullPathname, '.m'];
    end
else
    sFullPathname = [];
    return
end

end

%% Hungarian Notation - Variable Prefixes
%
% Prefix        Meaning
% ------        -------
% v             vector
% m             matrix (2d)
% ts            time series (3d)
% t             3d matrix (same as time series)
% z             complex (z = x + iy)
% b             logical (boolean)
% s             string
% c             cell
% o             structure (object)
% i             integer (or index)
% iv            index of a vector element
% n             whole number (or tota number)
% h             handle
% p             floating point single precision
% none          floating point double
% u8            unsigned 8-bit integer
% i8            signed 8-bit integer
%
% Examples      Meaning
% --------      -------
% vbAnswer      logical vector
% tzData        complex time series
% oView         structure
% csText        cell structure of strings
% cOther        cell structure
%
% This is the variable naming convention used to make the code easier to
% interpret and help in reducing errors.
%
% Khan - 02/15/2010 (see hungarian.m)
