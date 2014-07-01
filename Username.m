function [sName, sLogname] = Username

% [sName, sLogname] = Username;
% Returns the username of current user
% Khan 11/15/09

% sLogname = strtrim(linux('echo $LOGNAME'));
c = SqueezeCell(regexp(userpath, [filesep '|' pathsep], 'split'));
sLogname = c{regmatch(c, 'home|.*Users|.*Settings|.*Profiles') + 1};

switch(sLogname)
    % Lookup table
    case 'khan',        sName = 'Khan';
    case 'rkk225',      sName = 'Khan';
    case 'cag2725',     sName = 'Greene';
    case 'seo92',       sName = 'Okeke';
    case 'sokeke06',    sName = 'Okeke';
    case 'dr9774',      sName = 'Ress';
    case 'sd3698',      sName = 'Darayan';
    case 'sdarayan',    sName = 'Darayan';
    case 'sk23383',     sName = 'Katyal';
    case 'zughnisg',    sName = 'Zugni';
    case 'dhandaps',    sName = 'Dhandap';
    case 'sd22685',     sName = 'Dhandap';
    otherwise % Try other methods to get username
        % Default is the login name
        sName = Capitalize(sLogname);
        
        % If possible, get information from finger        
        [sFinger, iError] = linux('finger $LOGNAME | grep Name:');
        
        if ~iError
            csFingerFirstLine = regexpi(sFinger, 'Name: ', 'split');
            sFingerFullname = csFingerFirstLine{end};
            csFingerNameSplit = regexpi(sFingerFullname, ' ', 'split');
            if isempty(csFingerNameSplit)
                sFingerName = sFingerFullname;
            else
                sFingerName = csFingerNameSplit{end};
            end
            
            % If finger successful, set user name from it
            sName = sFingerName; % Set to last name, if it exists
        end        
end

sName = strtrim(sName);

end
