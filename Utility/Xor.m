function y = Xor(x)
% function y = Xor(x)
% 
% Calculates the xor function for a pair of values in an array.
% 
% Inputs:
% x: The array to use.
% 
% Outputs:
% y: The result.
% 
% Author: Rodrigo García

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if length(x) ~= 2
        error('The input array must have two elements!');
    end
    
    y = xor(x(1),x(2));

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
