function value = Get_field_default(struct,field,default)
% function Get_field_default(struct,field,default)
% 
% Returns a given field in a struct, or a default value if the field
% doesn't exist.
% 
% Author: Rodrigo García

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if isfield(struct,field)
        value = struct.(field);
    else
        value = default;
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
