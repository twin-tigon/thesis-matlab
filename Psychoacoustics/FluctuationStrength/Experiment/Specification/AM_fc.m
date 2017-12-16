function spec = AM_fc
% function spec = AM_fc
% 
% Specification for AM-fc experiment.
% 
% Author: Rodrigo Garc?a

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Stimuli parameters
    params.FMs      = 4;
    params.FCs      = [125 250 500 1000 2000 4000 8000];
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
    
    stds(2).fm  = 4;
    stds(2).fc  = 250;
    stds(2).md  = 40;
    stds(2).SPL = 70;
    stds(2).w   = 25;
    stds(2).fs  = 44100;

    spec.name = 'AM-fc';
    spec.desc = [
        'Magnitude estimation experiment to determine the dependence ' ...
        'of center frequency on fluctuation strength for AM tones'
    ];
    spec.tone               = 'AM';
    spec.params             = params; 
    spec.stds               = stds;
    spec.std1               = 4;
    spec.n_stimuli          = length(params.FCs);
    spec.norm               = 84.4523;

    spec.plot.xlabel        = 'Center frequency [Hz]';
    spec.plot.x_handle      = @log2;
    spec.plot.dx            = 0.1;
    spec.plot.axis          = [-inf inf 40 140];
    
    spec.plot.experiment.x          = params.FCs;
    spec.plot.model.xticklabel      = params.FCs;
    spec.plot.fastl2007.x           = params.FCs;
    spec.plot.fastl2007.xticklabel  = params.FCs;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
