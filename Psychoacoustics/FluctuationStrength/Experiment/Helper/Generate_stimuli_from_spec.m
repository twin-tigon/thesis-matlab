function Generate_stimuli_from_spec(spec)
    
    format = Get_filename_read_format(spec.tone);
    cellfun(@(f)process_filename(f,format,spec)...
        ,Get_stimuli_filenames(spec));
    
    function process_filename(filename,format,spec)
        output_filename = [Get_path('APEX_stimulus') filename];
        
        if exist(output_filename,'file')
            fprintf('Filename "%s" already exists! Skipping...\n', ...
                filename);
            return;
        end
        
        params = Get_params_from_filename(filename,format);
        x      = Generate_waveform(spec.tone,params);
        
        Wavwrite(x,params.fs,output_filename);
    end

end