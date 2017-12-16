function params = Get_Hweight_params
% function params = Get_Hweight_params
% 
% Returns parameters for Hweight digital filter.
% 
% Outputs:
% params: Parameters struct.
% 
% Author: Rodrigo Garc?a

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    params = struct;
    params.sf1 = 0.5;
    params.pf1 = 2;
    params.pf2 = 8;
    params.sf2 = 32;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
end
