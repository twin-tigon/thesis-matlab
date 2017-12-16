function Create_params(fs,Chno,filename)
% function Create_params(Fs,Chno,filename)
% 
% Creates the params file containing all the required parameters for the
% fluctuation strength model.
% 
% Inputs:
% fs: the sampling frequency.
% Chno: the number of channels.
% filename: The output filename.
% 
% Author: Rodrigo Garc?a

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    Cal  = 0.25;
    
    Hweight = calculate_Hweight(fs);
    gzi     = calculate_gzi(Chno);
    
    OUTPUT_FILE = [Get_path('FluctuationStrength_Model_Data') filename];
    Delete(OUTPUT_FILE);
    save(OUTPUT_FILE,'-regexp','^(?!OUTPUT_FILE$).*');
    
    %% Helper functions

    function Hweight = calculate_Hweight(fs)
        Hweight = designfilt(...
            'bandpassiir', ...
            'StopbandFrequency1', 0.125, ...
            'PassbandFrequency1', 0.5, ...
            'PassbandFrequency2', 8, ...
            'StopbandFrequency2', 64, ...
            'StopbandAttenuation1', 100, ...
            'PassbandRipple', 3, ...
            'StopbandAttenuation2', 100, ...
            'SampleRate', fs);
    end

    function gzi = calculate_gzi(Chno)
        Chstep = 0.5;
        
        g0 = [
            0       0
            125     1
            250     1
            1000    1
            2000    1
            4000    1
            8000    1
            16000   0
        ];

        gzi = interp1(freqtoaud(g0(:,1),'bark'),g0(:,2),(1:Chno)*Chstep);
        gzi(isnan(gzi)) = 0;
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
