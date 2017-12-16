function Plot_stimuli(spec)
% function Plot_stimuli(spec)
% 
% Plots all stimuli contained in the experiment specification.
% 
% Author: Rodrigo García

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    wavfiles = cellfun(@(x)[ Get_path('APEX_stimulus') x ], ...
        Get_stimuli_filenames(spec), ...
        'UniformOutput',false);
    
    Plot_wavfiles(wavfiles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
