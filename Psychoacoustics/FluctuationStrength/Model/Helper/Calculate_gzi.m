function gzi = Calculate_gzi(Chno)
% function gzi = Calculate_gzi(Chno)
%
% Returns gzi parameters using the specified number of channels.
% 
% Inputs:
% Chno: The number of channels.
% 
% Outputs:
% gzi: The gzi vector.
% 
% Author: Rodrigo Garc?a

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    Chstep = 0.5;
    
    g0 = [
        0       0
        125     1
        250     1
        500     1
        1000    1
        1500    1
        2000    1
        3000    1
        4000    1
        6000    1
        8000    1
        16000   0
    ];
    
    gzi = interp1(freqtoaud(g0(:,1),'bark'),g0(:,2),(1:Chno)*Chstep);
    gzi(isnan(gzi)) = 0;
    
    gzi = ones(1,Chno);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
end
