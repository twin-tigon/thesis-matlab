function filename = Get_filename_from_params(format,fm,fc,md,SPL,w,fs,N)
% function filename = Get_filename_from_params(format,fm,fc,md,SPL,w,fs,N)
% 
% Returns filename from write format and params.
% 
% Author: Rodrigo García

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Calculates sample size to assure that the signal duration is
    % between 2 and 4 seconds
    tm = 1/fm;
    tt = 3*tm;

    if fm == 0
        tt = 2;
    elseif tt < 2
        tt = round(2/tm)*tm;
    elseif tt > 4
        tt = round(4/tm)*tm;
    end

    if N == 0
        N = tt*fs;
    end

    if fc == -1
        filename = sprintf(format,fm,md,SPL,w,fs,N);
    else
        filename = sprintf(format,fm,fc,md,SPL,w,fs,N);
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
end
