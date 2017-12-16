function [Median,errorL,errorU] = Prepare_errorbar_perc(y,percL,percU)
% function [Median,errorL,errorU] = Prepare_errorbar_perc(y,percL,percU)
%
% 1. Description:
%
% 2. Stand-alone example:
%
% 3. Additional info:
%       Tested cross-platform: Yes
%
% Programmed by Alejandro Osses, HTI, TU/e, the Netherlands, 2014-2015
% Created on    : 02/08/2015
% Last update on: 02/08/2015 % Update this date manually
% Last use on   : 02/08/2015 % Update this date manually
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

perc = [prctile(y,50) prctile(y,percL) prctile(y,percU)];
Median = perc(:,1);
errorL = Median-perc(:,2);
errorU = perc(:,3)-Median;
    
if nargout == 0
    
    figure; 
    errorbar(Median,errorL,errorU,'bx'); hold on
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
