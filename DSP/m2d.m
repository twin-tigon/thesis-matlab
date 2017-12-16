function [dp dn] = m2d(m)
% function [dp dn] = m2d(m)
%
% 1. Description:
%       Converts modulation factor 'm' to modulation depth 'd' mapped into:
%       1) positive values as defined by Fastl2007; 2) negative values as
%       used by Dau1997b. 
%       For a value of 'm' between 0 and 98 [%] you will get a modulation 
%       depth dp between 0 and 40 dB and dn between -40 to 0 dB.
% 
%       Nomenclature:   Modulation depth dp     = as used by Fastl2007.
%                       Modulation depth dn     = as used by Dau1997b.
% 
%   See also: d2m.m
% 
% 2. Stand-alone example:
%       [dp dn] = m2d(94)
% 
% 3. Additional info:
%       Tested cross-platform: yes
% 
% Programmed by Alejandro Osses, HTI, TU/e, the Netherlands, 2014-2015
% Created on    : 16/08/2014
% Last update on: 16/08/2014 % Update this date manually
% Last use on   : 01/04/2015 % Update this date manually
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if sum( m > 1 )>0 % then there are m values larger than 1
    m = m/100;
end

dp = 20 * log10( (1+m)./(1-m) );
dn = 20 * log10( m );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
