function spec = FM_fc
% function spec = FM_fc
% 
% Specification for FM-fc experiment.
% 
% Author: Rodrigo Garc?a

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Stimuli parameters
    params.FMs      = 4;
    params.FCs      = [500 1000 1500 2000 3000 4000 6000 8000];
    params.DFs      = 200;
    params.SPLs     = 70;
    params.Ws       = 25;
    params.FSs      = 44100;
    
    % Standards definition
    stds(1).fm  = 4;
    stds(1).fc  = 6000;
    stds(1).df  = 200;
    stds(1).SPL = 70;
    stds(1).w   = 25;
    stds(1).fs  = 44100;
    
    stds(2).fm  = 4;
    stds(2).fc  = 500;
    stds(2).df  = 200;
    stds(2).SPL = 70;
    stds(2).w   = 25;
    stds(2).fs  = 44100;

    spec.name = 'FM-fc';
    spec.desc = [
        'Magnitude estimation experiment to determine the dependence ' ...
        'of center frequency on fluctuation strength for FM tones'
    ];
    spec.tone               = 'FM';
    spec.params             = params; 
    spec.stds               = stds;
    spec.std1               = 7;
    spec.n_stimuli          = length(params.FCs);
    spec.norm               = 52.4875; %1.6797
    
    spec.plot.xlabel        = 'Center frequency [Hz]';
    spec.plot.x_handle      = @log2;
    spec.plot.dx            = 0.1;
    spec.plot.axis          = [-inf inf 0 140];
    
    spec.plot.experiment.x          = params.FCs;
    spec.plot.model.xticklabel      = params.FCs;
    spec.plot.fastl2007.x           = params.FCs;
    spec.plot.fastl2007.xticklabel  = params.FCs;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
