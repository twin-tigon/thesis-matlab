function paths = Get_Thesis_paths
    Thesis_base = '/Users/rodrigogarcialeon/Repositories/thesis-matlab';
    Psychoacoustics = [Thesis_base delim 'Psychoacoustics' delim];

    paths.DSP = [Thesis_base delim 'DSP' delim];
    paths.Utility = [Thesis_base delim 'Utility' delim];
    paths.PsySound32 = [Thesis_base delim 'tb_PsySound32' delim];
    
    RECURSIVE_PATHS = {
        [Psychoacoustics 'FluctuationStrength'];
        [Psychoacoustics 'Roughness'];
        [Thesis_base delim 'tb_APEX'];
        [Thesis_base delim 'tb_APEX_AddOns'];
        [Thesis_base delim 'tb_AMT'];
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

        warning('off');
        paths.(name) = [path delim];
        warning('on');
    end

    function basename = get_basename(path)
        splitted = strsplit(path,'/');
        basename = splitted{length(splitted)};
    end

    function last = get_last_part(path,basename)
        splitted = strsplit(path,'/');
        splitted = splitted(2:end);
        last = splitted(Stringindex(splitted,basename)+1:end);
        last = Celljoin(last,'_');
    end
end
