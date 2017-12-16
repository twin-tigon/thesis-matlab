function Hweight = Calculate_Hweight(params,fs)
% function Hweight = Calculate_Hweight(params,fs)
% 
% Returns the Hweight filter.
% 
% Inputs:
% params: Struct specifying filter characteristics.
% fs: Sampling frequency.
% 
% Outputs:
% Hweight: The digital filter.
% 
% Author: Rodrigo Garc?a

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
	Hweight = designfilt(...
        'bandpassiir', ...
        'StopbandFrequency1', params.sf1, ...
        'PassbandFrequency1', params.pf1, ...
        'PassbandFrequency2', params.pf2, ...
        'StopbandFrequency2', params.sf2, ...
        'StopbandAttenuation1', 100, ...
        'PassbandRipple', 3, ...
        'StopbandAttenuation2', 100, ...
        'SampleRate', fs);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
