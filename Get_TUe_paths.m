function paths = Get_TUe_paths
    MATLAB_base         = ['/Users/rodrigo/Documents/MATLAB' delim];
    MATLAB_shared       = [MATLAB_base 'MATLAB_shared' delim];
    Psychoacoustics     = [MATLAB_shared 'Psychoacoustics' delim];

    paths.DSP   = [MATLAB_shared 'DSP' delim];
    paths.Other = [MATLAB_shared 'Other' delim];
    
    RECURSIVE_PATHS = {
        [Psychoacoustics 'FluctuationStrength'];
        [MATLAB_shared 'tb_APEX'];
%         [MATLAB_shared 'tb_PsySound32'];
    };

    cellfun(@(path)add_path_recursively(path),RECURSIVE_PATHS);

    function add_path_recursively(basepath)
        basename = get_last_part(basepath);
        add_to_paths(basename,basepath);
        
        subpaths = strsplit(genpath(basepath),':');
        subpaths = subpaths(2:end-1);
        
        cellfun(@(path) ...
            add_to_paths([basename '_' get_last_part(path)],path), ...
            subpaths);
    end

    function add_to_paths(name,path)
        if isfield(paths,name)
            return
        end
        
        paths.(name) = [path delim];
    end

    function last = get_last_part(path)
        splitted    = strsplit(path,'/');
        last        = splitted{length(splitted)};
    end
end
