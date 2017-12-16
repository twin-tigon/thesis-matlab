function answers = Get_answers_from_APEX_results(results)
% function Get_answers_from_APEX_results
% 
% Derived the answer structs from the APEX results.
% 
% Inputs:
% results: The APEX results cell array.
% 
% Outputs:
% answers: The answer structs cell array.
% 
% Author: Rodrigo García

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    answers = cellfun(@(x)process_row(x),results,'UniformOutput',false);
    
    %% Helper functions    
    
    % Generates answer struct from results row
    function answer = process_row(row)
        split = strsplit(row,';');
        
        answer      = struct;
        answer.val  = str2double(split{6});
        answer.stim = str2double(strrep(split{3}, 'stim', ''));
        answer.std  = str2double(strrep(split{1}, 'procedure', ''));
    end

    %%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
