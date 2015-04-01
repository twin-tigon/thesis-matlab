function Start_TUe
    add_paths;
    init_toolboxes;
    
    function add_paths
        addpath('/Users/rodrigo/Documents/MATLAB/MATLAB_shared/Utility/');
        paths = Get_TUe_paths;
        Add_paths(paths);
    end

    function init_toolboxes
        psysound3;
    end
end