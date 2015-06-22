function path = Get_path(name)
% function path = Get_path(name)
% 
% Function to retrieve support paths that change according to the runtime
% environment.
% 
% Author: Rodrigo García

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    paths.Stimulus = [ ...
        '/Users/rodrigo/VirtualBox VMs/Luxuria/share/APEX_shared/stimulus/'
    ];
    
    if ~isfield(paths,name)
        error('The requested path has not been defined!');
    end
    
    path = paths.(name);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
