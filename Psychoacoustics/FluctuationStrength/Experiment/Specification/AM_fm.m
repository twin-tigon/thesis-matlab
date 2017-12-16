function spec = AM_fm
% function spec = AM_fm
% 
% Specification for AM-fm experiment.
% 
% Author: Rodrigo Garc?a

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Stimuli parameters
    params.FMs      = [0 0.25 0.5 1 2 4 8 16 32 64 128];
    params.FCs      = 1000;
    params.MDs      = 40;
    params.SPLs     = 70;
    params.Ws       = 25;
    params.FSs      = 44100;
    
    % Standards definition
    stds(1).fm  = 4;
    stds(1).fc  = 1000;
    stds(1).md  = 40;
    stds(1).SPL = 70;
    stds(1).w   = 25;
    stds(1).fs  = 44100;
    
    stds(2).fm  = 0.5;
    stds(2).fc  = 1000;
    stds(2).md  = 40;
    stds(2).SPL = 70;
    stds(2).w   = 25;
    stds(2).fs  = 44100;

    spec.name = 'AM-fm';
    spec.desc = [
        'Magnitude estimation experiment to determine the dependence ' ...
        'of modulation frequency on fluctuation strength for AM tones'
    ];
    spec.tone               = 'AM';
    spec.params             = params; 
    spec.stds               = stds;
    spec.std1               = 6;
    spec.n_stimuli          = length(params.FMs);
    spec.norm               = 83.6162;
    
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
