function Plot_results(specs)
% function Plot_results
% 
% Plots all APEX results files using common settings.
% 
% Inputs:
% specs: The experiment specifications to plot.
% 
% Author: Rodrigo Garc?a

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if nargin == 0
        specs = Get_specs;
    end
    
    % Defines common settings
    settings = struct;
    
    settings.individual_results = true;
    settings.group_results      = true;
    settings.stds_results       = true;
    settings.comparison_results = true;
    settings.smooth             = false;
    settings.show_figures       = false;
    settings.save_figures       = true;
    
    cellfun(@(x)Plot_experiment_results(x,settings),specs);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
