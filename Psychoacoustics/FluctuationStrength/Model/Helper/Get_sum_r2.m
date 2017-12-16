function s = Get_sum_r2(experiment,model)
% function x = Get_x_values_from_spec(spec)
% 
% Returns the sum of the difference of squares between the experiment and
% the model data.
% 
% Inputs:
% experiment: The experimental data.
% model: The model data.
% 
% Outputs:
% s = The sum of the differences r-squared vector.
% 
% Author: Rodrigo Garc?a

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    r = experiment-model';
    s = sum(r.^2);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
