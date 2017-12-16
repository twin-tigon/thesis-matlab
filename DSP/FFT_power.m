function [f,p] = FFT_power(y,fs)
% function [f,p] = FFT_power(y,fs)
% 
% Given a signal and its sampling frequency, calculates the FFT power
% spectrum associated to it.
% 
% Inputs:
% y:    The signal to analyze.
% fs:   Sampling frequency of the signal.
% 
% Outputs:
% f:    Frequency vector of the FFT power spectrum.
% p:    The FFT power spectrum itself.
% 
% Author: Rodrigo García
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    m = length(y);
    n = pow2(nextpow2(m));
    
    f = (0:n-1) * fs / n;
    s = fft(y,n);
    p = s .* conj(s) / n;
    
    h = floor(n / 2);
    f = f(1:h);
    p = 2 * p(1:h);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

