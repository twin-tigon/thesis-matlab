function model = Get_model_data(spec,params)
% function model = Get_model_data(spec,params)
% 
% Returns the model data for a given specification and model parameters.
% 
% Inputs:
% spec: The specification to use.
% params: The model parameters.
% 
% Outputs:
% model: The model data.
% 
% Author: Rodrigo Garc?a

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    model = cellfun(@(f)Get_fluctuation_strength(f,spec,params)...
        ,Get_stimuli_filenames(spec,params.N));
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
end
