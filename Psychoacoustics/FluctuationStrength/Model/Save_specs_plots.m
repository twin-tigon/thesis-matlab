function Save_specs_plots
% function Save_specs_plots
% 
% Saves all specs plots figures
% 
% Author: Rodrigo Garc?a

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    BASE_PATH = Get_path('LaTeX_FluctuationStrength_Model_Data_Fitting_img');
    TAG       = 'pre';

    specs = Get_specs;
    cellfun(@(s)process_spec(s),specs);
    
    function process_spec(spec)
        Plot_spec_experiment_model(spec);
        
        filename = [BASE_PATH 'garcia2015_' lower(spec.name) '_' TAG];
        Save_figure(filename);
        
        close;
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
