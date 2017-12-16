function y = Generate_AM_tone(Fc,Fmod,Mdept,SPL,Fs,N)
% function Generate_AM_tone(Fc,Fmod,Mdept,SPL,Fs,N)
% 
% Generates an AM tone with a -pi/2 phase shift in the envelope signal.
% 
% Author: Rodrigo García

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    x = (1+Mdept*sin((2*pi*Fmod*(1:N)/Fs)-pi/2)).*sin(2*pi*Fc*(1:N)/Fs);
    y = x*From_dB(SPL-103)/mean(rms(x));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end