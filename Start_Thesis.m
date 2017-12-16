function Start_Thesis
    add_paths;
    init_toolboxes;
    
    function add_paths
        addpath([pwd '/Utility/']);
        paths = Get_Thesis_paths;
        Add_paths(paths);
    end

    function init_toolboxes
        psysound3;
        amtstart;
    end
end