function [y,Fs,bits,opt_ck] = Wavread(filename)
% function [y,Fs,bits,opt_ck] = Wavread(filename)
%
% 1. Description:
%       Loads an audio file using audioread (available in MATLAB versions
%       released after 2013). Otherwise use wavread.
% 
% 2. Stand-alone example:
%
% 3. Additional info:
%       Tested cross-platform: No
% 
% Programmed by Alejandro Osses, HTI, TU/e, the Netherlands, 2014
% Created on    : 23/06/2014
% Last update on: 13/08/2014 % Update this date manually
% Last use on   : 31/03/2015 % Update this date manually
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    [y,Fs,bits,opt_ck] = audioread(filename);
catch
    [y,Fs,bits,opt_ck] = wavread(filename);
end
disp([mfilename '.m: ' filename ' read'])

if nargout == 0
    try
        fprintf('%s.m: RMS of %.2f [dBFS]\n',mfilename,rmsdb(y))
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
