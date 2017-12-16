function Plot_all_specs
% function Plot_all_specs
% 
% Plot experimental and model data for all specifications.
% 
% Author: Rodrigo Garc?a

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    specs_all = { ...
        {AM_fm;AM_fc;AM_SPL;AM_md} ...
        {FM_fm;FM_fc;FM_SPL;FM_df} ...
    };

    handles = struct;
    
    tic
    for k = 1:length(specs_all)
        figure;
        specs = specs_all{k};
        for l = 1:length(specs)
            handles.figure = @()subplot(2,2,l);
            Plot_spec_experiment_model(specs{l},handles);
        end
    end
    toc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
