function Generate_FM_all_stimulus
% function Generate_FM_all_stimulus
% 
% Joins all stimuli into one wav file.
% 
% Author: Rodrigo García

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    OUTPUT = 'FM-all.wav';

    FILENAMES = {
        'FM-fm_0.25-fc_1500-df_700-SPL_70-w_25-fs_44100-N_176400.wav';
        'FM-fm_64.00-fc_1500-df_700-SPL_70-w_25-fs_44100-N_88200.wav';
        'FM-fm_32.00-fc_1500-df_700-SPL_70-w_25-fs_44100-N_88200.wav';
        'FM-fm_2.00-fc_1500-df_700-SPL_70-w_25-fs_44100-N_88200.wav';
        'FM-fm_1.00-fc_1500-df_700-SPL_70-w_25-fs_44100-N_132300.wav';
        'FM-fm_0.00-fc_1500-df_700-SPL_70-w_25-fs_44100-N_88200.wav';
        'FM-fm_8.00-fc_1500-df_700-SPL_70-w_25-fs_44100-N_88200.wav';
        'FM-fm_4.00-fc_1500-df_700-SPL_70-w_25-fs_44100-N_88200.wav';
        'FM-fm_0.50-fc_1500-df_700-SPL_70-w_25-fs_44100-N_176400.wav';
        'FM-fm_128.00-fc_1500-df_700-SPL_70-w_25-fs_44100-N_88200.wav';
        'FM-fm_16.00-fc_1500-df_700-SPL_70-w_25-fs_44100-N_88200.wav';
    };

    nFiles = length(FILENAMES);
    
    output = [];
    for iFile = 1:nFiles
        [data, Fs]  = audioread([ Get_path('APEX_stimulus') ...
            FILENAMES{iFile} ]);
        output      = [output; data];
        if iFile ~= nFiles
            output = [output; zeros(800e-3*Fs,1)];
        end
    end
    
    audiowrite([ Get_path('APEX_stimulus') OUTPUT ], output, Fs);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end

