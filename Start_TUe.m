function Start_TUe
    INIT_TOOLBOXES  = 0;
    START_DIR       = 'FluctuationStrength';

    add_paths;
    
    if INIT_TOOLBOXES
        init_toolboxes;
    end
    
    if exist('START_DIR','var')
        goto_directory(START_DIR);
    end
    
    function add_paths
        addpath('/Users/rodrigo/Documents/MATLAB/MATLAB_shared/Utility/');
        paths = Get_TUe_paths;
        Add_paths(paths);
    end

    function init_toolboxes
        psysound3;
    end

    function goto_directory(dir)
        paths = Get_TUe_paths;
        cd(paths.(dir));
    end
end