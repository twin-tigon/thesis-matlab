function params = Get_roughness_params
% function params = Get_roughness_params
% 
% Returns a struct with all the required parameters for the roughness
% model.
% 
% Outputs:
% params: Parameters struct
%
% Author: Rodrigo Garc?a
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

    PARAMS_FILE = [
        Get_path('Roughness_Helper') ...
        'Roughness_params.mat'
    ];

    if ~exist(PARAMS_FILE,'file')
        Create_roughness_params(PARAMS_FILE);
    end
    
    params = load(PARAMS_FILE);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end