function format = Get_filename_write_format(tone)
% function format = Get_filename_write_format(tone)
% 
% Defines write format specification.
% 
% Author: Rodrigo García

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if strcmp(tone,'FM')
        mddf = 'df';
    else
        mddf = 'md';
    end
    
    if strcmp(tone,'AM_BBN')
        fc_str = '';
    else
        fc_str = '-fc_%d';
    end

    format = [
        tone ...
        '-fm_%.2f' ...
        fc_str ...
        ['-' mddf '_%d'] ...
        '-SPL_%d' ...
        '-w_%d' ...
        '-fs_%d' ...
        '-N_%d' ...
        '.wav'
    ];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
end
