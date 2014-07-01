function MountSSHFS(sLoginName, sHost)

% MountSSHFS(sLoginName, sHost);
%
% SSH mounts mri and software on sandstone
%
% Khan  09/22/09

%% Default params
if ~exist('sHost', 'var'), sHost='sandstone'; end
if ~exist('sLoginName', 'var'), sLoginName = lower(username); end

%% Main
% Check if they are already mounted
sLinuxHome = linux('echo $HOME'); sLinuxHome = sLinuxHome(1:end-1);
sSSHMount = linux(['mount -l -t fuse.sshfs | grep -ic "', sLoginName, '@', sHost, ':/export on ', sLinuxHome, '/export"']);

bSSHMounted = logical(str2double(sSSHMount));

% Check if identities were added
bIdentityAdded = logical(str2double(linux('ssh-add -l | grep -ic home')));

% Mount them
if ~bSSHMounted && bIdentityAdded
    system(['sshfs ', sLoginName, '@', sHost, ':/export/data/mri ~/export/mri -o nonempty']);
    system(['sshfs ', sLoginName, '@', sHost, ':/export/data/software ~/export/software -o nonempty']);
end

end

%% Note: type "doc hungarian" for variable prefix explanation.
