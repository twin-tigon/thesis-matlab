function spec = FM_fm
% function spec = FM_fm
% 
% Specification for FM-fm experiment.
% 
% Author: Rodrigo Garc?a

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Stimuli parameters
    params.FMs      = [0 0.25 0.5 1 2 4 8 16 32 64 128];
    params.FCs      = 1500;
    params.DFs      = 700;
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
    
    stds(2).fm  = 0.5;
    stds(2).fc  = 1500;
    stds(2).df  = 700;
    stds(2).SPL = 70;
    stds(2).w   = 25;
    stds(2).fs  = 44100;

    spec.name = 'FM-fm';
    spec.desc = [
        'Magnitude estimation experiment to determine the dependence ' ...
        'of modulation frequency on fluctuation strength for FM tones'
    ];
    spec.tone               = 'FM';
    spec.params             = params; 
    spec.stds               = stds;
    spec.std1               = 6;
    spec.n_stimuli          = length(params.FMs);
    spec.norm               = 38.3302;
    
    spec.plot.xlabel        = 'Modulation frequency [Hz]';
    spec.plot.x_handle      = @log2;
    spec.plot.dx            = 0.1;
    spec.plot.axis          = [-inf inf 0 160];
    
    spec.plot.experiment.x          = params.FMs;
    spec.plot.model.xticklabel      = params.FMs;
    spec.plot.fastl2007.x           = [0.25 0.5 1 2 4 8 16 32];
    spec.plot.fastl2007.xticklabel  = spec.plot.fastl2007.x;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
