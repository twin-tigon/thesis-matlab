function params = Get_fluctuation_strength_params
% function params = Get_fluctuation_strength_params
% 
% Returns parameters for model debug mode.
% 
% Outputs:
% params: The parameters struct.
% 
% Author: Rodrigo Garc?a

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    params         = struct;
    params.fs      = 44100;
    params.N       = 12*params.fs;
    params.Chno    = 47;
    params.debug   = 'none';
    params.Hweight = Calculate_Hweight(Get_Hweight_params,params.fs);
	params.gzi     = Calculate_gzi(params.Chno);
    params.p_g     = 2;
    params.p_m     = 0.25;
    params.p_k     = 0.375;
    params.cal     = 0.15;
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
end
