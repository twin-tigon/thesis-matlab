function y = Generate_AM_BBN(fm,md,SPL,fs,N)
% function y = Generate_AM_BBN(fm,md,SPL,fs,N)
% 
% Generates an AM BBN stimulus.
% 
% Author: Rodrigo García

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    x = (1+md*sin((2*pi*fm*(1:N)/fs)-pi/2)).*randn(1,N);
    y = x*From_dB(SPL-103)/mean(rms(x));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
end
