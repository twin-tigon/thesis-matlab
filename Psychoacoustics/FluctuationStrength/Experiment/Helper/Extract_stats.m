function [m,l,u] = Extract_stats(vals)
% function [m,l,u] = Extract_stats(vals)
%
% Returns the median, lower and upper interquartile values for a vector.
% 
% Inputs:
% vals: The vector to use.
% 
% Outputs:
% m: The median.
% l: The lower iqr limit.
% u: The upper iqr limit.
% 
% Author: Rodrigo García

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    m = cellfun(@(x)median(x,'omitnan'),vals);
    l = m - cellfun(@(x)prctile(x,25),vals);
    u = cellfun(@(x)prctile(x,75),vals) - m;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
end
