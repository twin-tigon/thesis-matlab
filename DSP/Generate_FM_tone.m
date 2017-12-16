function y = Generate_FM_tone(fc,fm,df,SPL,fs,N)
% function y = Generate_FM_tone(fc,fm,df,SPL,fs,N)
% 
% Generates an FM tone with a -pi/2 phase shift in the modulating signal.
% 
% Author: Rodrigo García

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    Amp     = From_dB(SPL - 100);
    wstep   = 2*pi/fs;
    Sig     = zeros(N,1);
    dw		= 0;

    for q =	1:1:N;
        dw      = dw + wstep*(fc - df*cos(wstep*fm*q));
        Sig(q)	= Amp*sin(dw);
    end
    
    y = Sig;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end