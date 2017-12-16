function x = Get_x_values_from_spec(spec)
% function x = Get_x_values_from_spec(spec)
% 
% Returns x values for plots based on specification.
% 
% Inputs:
% spec: The specification to use.
% 
% Outputs:
% x: The x values vector.
% 
% Author: Rodrigo Garc?a

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    x = spec.plot.x_handle(spec.plot.experiment.x);

    % Ugly hack to accomodate for Inf value in *-fm experiments
    if Vectorreduce(isinf(x),@or)
        x(1) = x(2) - 1;
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
