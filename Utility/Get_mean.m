function [m,s,ci,iq] = Get_mean(data)
% function [m,s,ci,iq] = Get_mean(data)
%
% 1. Description:
%       Gets the typical statistics ignoring NaN data:
%           'm' = mean
%           's' = standard deviation 
%           'ci' = confidence interval
%           'iq' = Interquartile range
%       For the interquartile range, the length of the error bars is returned
%       in the rows 2 and 3 for the percentile 25 and 75 respectively in order
%       to be used as input to the errorbar function. 
% 
% 2. Stand-alone example:
%           data = [ 12   25    50    75    50   100   175   175   200   200     0; ...
%                    15   25    50    36    50   100   175   200   175   200   150; ...
%                    20  100    92   123   100   100    76    87    51    50    16; ...
%                    0   127   137   100   100   100    87    63    74    76     8; ...
%                    2   102   100   126    83   100    68    83    74    50     8; ...
%                    0   137   114   100   100   100    68    80    52    25     8];
%           [m,s,ci,iq] = Get_mean(data);
%           figure; 
%           errorbar(1:length(iq(1,:)),iq(1,:),iq(2,:),iq(3,:));
%           xlabel('Order of presentation')
%           ylabel('Amplitude')
%           title('data considering IQR')
% 
%           figure; 
%           errorbar(1:length(m),m,s,'r');
%           xlabel('Order of presentation')
%           ylabel('Amplitude')
%           title('data considering mean and std')
%  
%   See also errorbar
% 
% Programmed by Matthias Milczynski, ExpORL, KU Leuven, Belgium 2008-2011
% Edited by Alejandro Osses, HTI, TU/e, the Netherlands, 2014-2015
% Last update on : 02/08/2015
% Last use on    : 02/08/2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

m = nan(1, size(data, 2)); % zeros
s = nan(1, size(data, 2)); % zeros
ci = nan(1, size(data, 2)); %zeros
iq = nan(3, size(data, 2)); %zeros

for j=1:size(data, 2)
    d = data(:, j);
    idx = find(isnan(d)); %-1;
    if length(idx > 0)
        warning(sprintf('Excluding from mean and std calculation %.0f NaN data point(s)',length(idx)));
    end
    d(idx) = [];
    if ~isempty(d)
        %if obj.interval
        m(1, j) = mean(d);
        s(1, j) = std(d);
        ci(1, j) = confidenceInterval(d);
        percL = 25;
        percU = 75;
        [Median,errorL,errorU] = Prepare_errorbar_perc(d,percL,percU);
        iq(1, j) = Median;
        iq(2, j) = errorL;
        iq(3, j) = errorU;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
