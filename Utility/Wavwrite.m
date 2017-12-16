function Wavwrite(x,fs,outputfilename)
% function Wavwrite(x,fs,outputfilename)
% 
% 1. Description:
%       Write Microsoft WAVE (".wav") sound file
% 
% 2. Stand-alone example:
%
% 3. Additional info:
%       Tested cross-platform: No
%
% Programmed by Alejandro Osses, HTI, TU/e, the Netherlands, 2014
% Created on    : 13/05/2014
% Last update on: 31/03/2015 % Update this date manually
% Last use on   : 31/03/2015 % Update this date manually
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
try
    audiowrite(outputfilename,x,fs);
catch
    wavwrite(x,fs,outputfilename);
end

disp([mfilename '.m: file ' outputfilename ' created'])
try
    fprintf('%s.m: RMS of %.2f [dBFS]\n',mfilename,rmsdb(x))
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
