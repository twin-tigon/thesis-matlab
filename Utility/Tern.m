function o = Tern(p,t,f)
% function o = Tern(p,t,f)
% 
% Basic ternary operator.
% 
% Inputs:
% p: Predicate.
% t: Output if true.
% f: Output if false.
% 
% Outputs:
% o: Result.
% 
% Author: Rodrigo García

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if p
        o = t;
    else
        o = f;
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
