function fs = Get_fluctuation_strength(filename,spec,m_p)
% function fs = Get_fluctuation_strength(filename,spec,m_p)
% 
% Returns fluctuation strength value using debug model.
% 
% Inputs:
% filename: The stimulus filename.
% spec: The specificaiton to use.
% m_p: The model parameters struct.
% 
% Outputs:
% fs: The fluctuation strength value.
% 
% Author: Rodrigo Garc?a

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Generate stimulus parameters
    format   = Get_filename_read_format(spec.tone);
    s_p      = Get_params_from_filename(filename,format);
    s_p.tone = spec.tone;

    x  = Generate_waveform(spec.tone,s_p,false);
    fs = FluctuationStrength_debug(x,s_p,m_p);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
end
