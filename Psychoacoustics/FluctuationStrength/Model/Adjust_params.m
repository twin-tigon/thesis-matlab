function Adjust_params(spec)
% function Adjust_params(spec)
% 
% Plot experiment and model data from specification using adjusted model
% parameters.
% 
% Inputs:
% spec: The specification to use.
% 
% Author: Rodrigo Garc?a

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if nargin == 0
        spec = AM_fm;
    end
    
    handles = struct;
    handles.params = @get_adjusted_params;

    Plot_spec_experiment_model(spec,handles);

    function params = get_adjusted_params
        params = Get_fluctuation_strength_params;
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
