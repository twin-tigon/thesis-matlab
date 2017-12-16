function filenames = Get_standards_filenames(stds,tone)
% function filenames = Get_standards_filenames(stds)
% 
% Returns standards' filenames.
% 
% Author: Rodrigo García

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    filenames = cell(length(stds),1);

    for iStd = 1:length(stds)
        if strcmp(tone,'AM_tone')
            mddf = stds(iStd).md;
        else
            mddf = stds(iStd).df;
        end
        
        filenames{iStd,1} = Get_filename_from_params( ...
            Get_filename_write_format(tone), ...
            stds(iStd).fm, ...
            stds(iStd).fc, ...
            mddf, ...
            stds(iStd).SPL, ...
            stds(iStd).w, ...
            stds(iStd).fs ...
        );
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
