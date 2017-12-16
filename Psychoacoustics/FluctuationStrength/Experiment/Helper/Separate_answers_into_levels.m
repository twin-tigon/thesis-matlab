function levels = Separate_answers_into_levels(answers,n)
% function levels = Separate_answers_into_levels(answers,n)
% 
% Separates answers into cell arrays according to level.
% 
% Inputs:
% answers: The cell array of answers structs.
% n: The number of levels to use.
% 
% Outputs:
% levels: The resulting cell array.
% 
% Author: Rodrigo García

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    levels = arrayfun(@(x)Cellfilter(answers,@(y)y.stim==x),1:n ...
        ,'UniformOutput',false);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
