function r = Vectorreduce(v,h,c)
% function r = Vectorreduce(v,h,c)
% 
% Reduces an vector using a provided function handle and a carry.
%
% Inputs:
% v: The vector to reduce.
% h: The function handle to use.
% c: The carry to use, if not specified it will use the first element of
% the vector.
% 
% Outputs:
% r: The result.
% 
% Author: Rodrigo García

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if nargin == 0
        error('You must provide a vector to reduce!');
    end
    
    v_s = size(v);

    if v_s(1) > 1 && v_s(2) > 1
        error('You must provide a vector!');
    end
    
    v_l = length(v);
    
    if v_l < 2
        error('The vector must have at least two elements!');
    end
    
    if nargin == 1
        error('You must provide a function handle!');
    end
    
    if nargin == 2
        s_i = 2;
        r   = v(1);
    else
        s_i = 1;
        r   = c;
    end
    
    for n = s_i:v_l
        r = h(r,v(n));
    end
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
