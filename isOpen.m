function bIsOpen = isOpen(sCheckFilename)

% bIsOpen = isOpen(sCheckFilename);
%
% Check if file is open in editor.
%
% Khan 02/22/2010

%% Default params

%% Initialize
csOpenFiles = CurrentlyOpenFiles;
bIsOpen = false;

%% Main
for iFile = 1:length(csOpenFiles)
    sOpenFilename = csOpenFiles{iFile};
    if strcmp(sOpenFilename, GetFullPathname(sCheckFilename))
        bIsOpen = true;
        return;
    end
end

end %function

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
