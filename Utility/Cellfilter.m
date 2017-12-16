function f = Cellfilter(c,h)
% function filtered = Cellfilter(c,h)
% 
% Returns a filtered cell array using the supplied predicate function.
% 
% Inputs:
% c: The cell array to filter.
% h: The function handle to use as a predicate.
% 
% Outputs:
% f: The filtered cell array.
% 
% Author: Rodrigo García

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    f = c(cellfun(h,c));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
