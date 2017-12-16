function y = Do_cos_ramp(x,fs,attack,release)
% function y = Do_cos_ramp(x,fs,attack,release)
%
% 1. Description:
%       Applies a cosine ramp with attack and release times given in [ms]
% 
% 2. Additional info:
%       Tested cross-platform: No
%
% 3. Stand-alone example:
%       
% Programmed by Alejandro Osses, HTI, TU/e, the Netherlands, 2014
% Created on    : 20/08/2014
% Last update on: 20/08/2014 % Update this date manually
% Last use on   : 20/08/2014 % Update this date manually
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin < 2
    fs = 44100;
    warning('Using default sampling frequency of 44100 Hz');
end

if nargin < 3
    attack = 25;
end

if nargin < 4
    release = attack;
end

sig_len = length(x);
r =  cos_ramp(sig_len,fs,attack,release);
try
    y = transpose(r).*x;
catch
    y = r.*x;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
