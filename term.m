function term(sDir)
% Needs to be modified to accomodate mac/windows
% Khan 02/03/2010

sCurDir = pwd;

if defined('sDir')
    cd(sDir)
end

if isunix
    linux(['gnome-terminal --working-directory=',pwd,'&']);
else
    disp('Please edit the function to accomodate mac/windows');
end

cd(sCurDir);

end