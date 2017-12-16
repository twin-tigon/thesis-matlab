function struct2vars(struct)
% function struct2vars(struct)
% 
% Saves all the fields of a given struct as separate variables in the
% caller workspace.
% 
% Inputs:
% struct: The struct to use.
% 
% Author: Rodrigo Garc?a
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    for cell = fieldnames(struct)'
        assignin('caller',cell{1},struct.(cell{1}));
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
end
