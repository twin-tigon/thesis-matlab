
function vals = Get_values_per_level(answers,n)
% function vals = Get_values_per_level(answers,n)
% 
% Gets answers values per level.
% 
% Inputs:
% answers: The cell array of answers structs to use.
% n: The number of levels to separate into.
% 
% Outputs:
% vals: The separated values.
% 
% Author: Rodrigo García

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    levels  = Separate_answers_into_levels(answers,n);
    vals    = cellfun(@Extract_values,levels,'UniformOutput',false);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
