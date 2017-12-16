function Generate_model_data
% function Generate_model_data
% 
% Generates model data
% 
% Author: Rodrigo Garc?a

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    delete([Get_path('FluctuationStrength_Model_Data') '*.mat'])

    params = Get_fluctuation_strength_params;
    params.debug = 'none';

    specs = Get_specs;
    
    tic;
    cellfun(@(s)process_spec(s),specs);
    toc;
    
    function process_spec(spec)
        fprintf('Processing spec %s...\n',spec.name);
        Get_model_data(spec,params);
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
