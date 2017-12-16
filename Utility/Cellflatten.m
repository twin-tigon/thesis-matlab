function f = Cellflatten(c)
% function flattened = Cellflatten(cell)
% 
% Flattens a given cell array by one level of depth.
% 
% Inputs:
% c: The cell array to flatten.
% 
% Outputs:
% f: The resulting flattened cell array.
% 
% Author: Rodrigo García

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    f = {};
    for n = 1:length(c)
        f = [f; c{n}];
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
