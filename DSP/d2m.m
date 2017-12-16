function m = d2m(d,method)
% function m = d2m(d,method)
%
% 1. Description:
%       Converts modulation depth 'd' into modulation factor 'm'. Enter a 
%       value 'd' in [dB]
% 
%       Nomenclature as used by Fastl2007.
% 
% 2. Stand-alone example:
%       m = d2m(40)
% 
% 3. Additional info:
%       Tested cross-platform: yes
% 
% Programmed by Alejandro Osses, HTI, TU/e, the Netherlands, 2014
% Created on    : 05/03/2015
% Last update on: 01/04/2015 % Update this date manually
% Last use on   : 01/04/2015 % Update this date manually
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin < 2
    if d < 0
        method = 'dau';
    elseif d > 0
        method = 'fastl';
    else
        error('define a method: either ''dau'' or ''fastl''');
    end       
end

switch method
    case 'fastl'
        m = ( 10.^(d/20)-1 )/( 10.^(d/20)+1 );
    case 'dau'
        m = ( 10.^(d/20) );
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
