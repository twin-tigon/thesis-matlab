function spec = FM_df
% function spec = FM_df
% 
% Specification for FM-df experiment.
% 
% Author: Rodrigo Garc?a

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Stimuli parameters
    params.FMs      = 4;
    params.FCs      = 1500;
    params.DFs      = [16 32 100 300 700];
    params.SPLs     = 70;
    params.Ws       = 25;
    params.FSs      = 44100;
    
    % Standards definition
    stds(1).fm  = 4;
    stds(1).fc  = 1500;
    stds(1).df  = 700;
    stds(1).SPL = 70;
    stds(1).w   = 25;
    stds(1).fs  = 44100;
    
    stds(2).fm  = 4;
    stds(2).fc  = 1500;
    stds(2).df  = 32;
    stds(2).SPL = 70;
    stds(2).w   = 25;
    stds(2).fs  = 44100;

    spec.name = 'FM-df';
    spec.desc = [
        'Magnitude estimation experiment to determine the dependence ' ...
        'of frequency deviation on fluctuation strength for FM tones'
    ];
    spec.tone               = 'FM';
    spec.params             = params; 
    spec.stds               = stds;
    spec.std1               = 5;
    spec.n_stimuli          = length(params.DFs);
    spec.norm               = 50;
    
    spec.plot.xlabel        = 'Frequency deviation [Hz]';
    spec.plot.x_handle      = @log2;
    spec.plot.dx            = 0.1;
    spec.plot.axis          = [-inf inf 0 140];
    
    spec.plot.experiment.x          = params.DFs;
    spec.plot.model.xticklabel      = params.DFs;
    spec.plot.fastl2007.x           = [16 32 100 NaN 300 NaN 700];
    spec.plot.fastl2007.xticklabel  = {'16' '32' '100' '' '300' '' '700'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
