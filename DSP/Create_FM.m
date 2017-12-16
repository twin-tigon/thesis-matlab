function y = Create_FM(fc,fm,df,SPL,fs,N)
% function y = Create_FM(fc,fm,df,SPL,fs,N)
% 
% Generates a frequency-modulated tone time vector.
% 
% Inputs:
%   fc:   carrier frequency       [Hz]
%   fm:   modulation frequency    [Hz]
%   df:   frequency deviation     [Hz]
%   SPL:  sound pressure level    [dB]
%   fs:   sampling frequency      [Hz]
%   N:    number of samples
% 
% Outputs:
%   y:    The frequency-modulated vector
% 
% Created by:               Dik Hermes
% Additional comments by:   Rodrigo García

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    Amp     = From_dB(SPL - 100);
    wstep   = 2*pi/fs;
    Sig     = zeros(N,1);
    dw		= 0;

    for q =	1:1:N;
        dw      = dw + wstep*(fc + df*sin(wstep*fm*q));
        Sig(q)	= Amp*sin(dw);
    end
    
    y = Sig;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
