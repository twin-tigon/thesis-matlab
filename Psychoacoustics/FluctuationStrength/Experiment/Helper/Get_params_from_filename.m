function params = Get_params_from_filename(name,format)
% function filename = Get_params_from_filename(name,format)
% 
% Returns params from name and read format.
% 
% Author: Rodrigo García

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    values = sscanf(name,format);
    tokens = regexp(name,'-(\D+)_','tokens');

    params = struct;

    for idx = 1:length(tokens)
        params.(char(tokens{idx})) = values(idx);
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
end
