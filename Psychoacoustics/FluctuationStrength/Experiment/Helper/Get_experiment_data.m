function y = Get_experiment_data(spec)
% function y = Get_experiment_data(spec)
% 
% Returns experimental data given a specification.
% 
% Inputs:
% spec: The specification to use.
% 
% Outputs:
% y: The experimental data.
% 
% Author: Rodrigo Garc?a

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    data = load([Get_path('FluctuationStrength_Experiment_Data') ...
        spec.name '.mat']);
    n = spec.n_stimuli;

    vals_1 = Get_values_per_level(...
        Cellfilter(data.answers,@(x)x.std==1),n);
    [m1,~] = Extract_stats(vals_1);
    vals_2 = Get_values_per_level(...
        Cellfilter(data.answers,@(x)x.std==2),n);
    [m2,~] = Extract_stats(vals_2);

    y = (m1+m2)*0.5/spec.norm;
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
