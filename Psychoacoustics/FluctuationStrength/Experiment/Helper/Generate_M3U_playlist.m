function Generate_M3U_playlist(spec)
% function Generate_M3U_playlist
% 
% Generates an M3U playlist containing all the stimuli present in an
% experiment specification.
% 
% Author: Rodrigo García

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    filenames = Get_stimuli_filenames(spec.tone,spec.params);
    
    fout = fopen([spec.name '.m3u'],'w');
    for iF = 1:length(filenames)
        fprintf(fout, ...
            '%s\n', [Get_path('APEX_stimulus') filenames{iF,1}]);
    end
    fclose(fout);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
