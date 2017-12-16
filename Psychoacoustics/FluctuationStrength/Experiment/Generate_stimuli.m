function Generate_stimuli(specs,generate_all)
% function Generate_stimuli(specs,generate_all)
% 
% Generates all stimuli from the experiment specifications
% 
% Inputs:
% specs: Cell array with the specifications to use.
% generate_all: Whether to generate the long stimuli.
% 
% Author: Rodrigo García

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if nargin < 1
        specs = Get_specs;
    end
    
    if nargin < 2
        generate_all = 0;
    end
    
    cellfun(@(s)Generate_stimuli_from_spec(s),specs);
    
    if generate_all
        Generate_AM_all_stimulus;
        Generate_FM_all_stimulus;
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
end
