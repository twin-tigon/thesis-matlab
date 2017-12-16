function result=delim
% function result=delim
% 
% 1. Description:
%       Returns file separator or 'delimiter' associated to the operating
%       system in use.
% 
% Programmed at ExpORL 2012-2013
% Comments by Alejandro Osses
% Last used on: 27-05-2014
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if (isunix)
    result='/';
else
    result='\';
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%