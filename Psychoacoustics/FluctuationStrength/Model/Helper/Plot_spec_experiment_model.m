function Plot_spec_experiment_model(spec,handles)
% function Plot_spec_experiment_model(spec,handles)
% 
% Plots experimental and model data based on specification.
% 
% Inputs:
% spec: The specification to use.
% handles: Struct containing function handles.
% 
% Author: Rodrigo Garc?a

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if nargin < 2
        handles = struct;
    end
    
    if nargin < 1
        spec = AM_fm;
    end
    
    if isfield(handles,'params')
        params = handles.params();
    else
        params = Get_fluctuation_strength_params;
    end

    x   = Get_x_values_from_spec(spec);
    y_e = Get_experiment_data(spec);
    y_m = Get_model_data(spec,params);
    
    if isfield(handles,'figure')
        handles.figure();
    else
        figure;
    end 
    
    Plot_experiment_model(x,y_e,y_m,spec);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
end
