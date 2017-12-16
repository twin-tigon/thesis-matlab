function j = Celljoin(c,s)
% function j = Celljoin(c,s)
% 
% Joins all the string contained in a cell array using the separator string
% provided.
% 
% Inputs:
% c: The cell array to use.
% s: The separator string.
% 
% Outputs:
% j: The joined string.
% 
% Author: Rodrigo García

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    j = c{1};
    
    for n = 2:length(c)
        j = [j s c{n}];
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end