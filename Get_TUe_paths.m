function paths = Get_TUe_paths
    MATLAB_base         = ['/Users/rodrigo/Documents/MATLAB' delim];
    MATLAB_shared       = [MATLAB_base 'MATLAB_shared' delim];
    Psychoacoustics     = [MATLAB_shared 'Psychoacoustics' delim];

    paths.DSP       = [MATLAB_shared 'DSP' delim];
    paths.Utility   = [MATLAB_shared 'Utility' delim];
    
    RECURSIVE_PATHS = {
        [Psychoacoustics 'FluctuationStrength'];
        [MATLAB_shared 'tb_APEX'];
        [MATLAB_shared 'tb_APEX_AddOns'];
        [MATLAB_shared 'tb_AMT'];
%         [MATLAB_shared 'tb_PsySound32'];
    };

    cellfun(@(path)add_path_recursively(path),RECURSIVE_PATHS);

    function add_path_recursively(basepath)
        basename = get_basename(basepath);
        add_to_paths(basename,basepath);
        
        subpaths = strsplit(genpath(basepath),':');
        subpaths = subpaths(2:end-1);
        
        cellfun(@(path) ...
            add_to_paths([basename '_' get_last_part(path,basename)]...
                ,path),subpaths);
    end

    function add_to_paths(name,path)
        if isfield(paths,name)
            return
        end
        
        paths.(name) = [path delim];
    end

    function basename = get_basename(path)
        splitted = strsplit(path,'/');
        basename = splitted{length(splitted)};
    end

    function last = get_last_part(path,basename)
        splitted    = strsplit(path,'/');
        splitted    = splitted(2:end);
        last        = splitted(Stringindex(splitted,basename)+1:end);
        last        = Celljoin(last,'_');
    end
end
