function status = Mkdir(folder)
% function status = Mkdir(folder)
%
% 1. Description:
%       Creates a folder only in case it does not exist previously
%       'status' is 1 if the directory was sucessfully created
%       'status' is 0 if the directory already exists.
%
% Programmed by Alejandro Osses, ExpORL, KULeuven, 2014
% Last update on: 12/08/2014
% Last use on   : 31/03/2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

bCreateFolder = ~isdir(folder);

if bCreateFolder == 1
    mkdir(folder);
    disp(['Directory ' folder 'created successfully...'])
else
    warning('Directory not created, it already exists, you might be overwriting files');
end

status = bCreateFolder;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
