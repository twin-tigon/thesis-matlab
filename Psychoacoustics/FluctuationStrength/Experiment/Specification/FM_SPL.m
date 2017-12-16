function spec = FM_SPL
% function spec = FM_SPL
% 
% Specification for FM-SPL experiment.
% 
% Author: Rodrigo Garc?a

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Stimuli parameters
    params.FMs      = 4;
    params.FCs      = 1500;
    params.DFs      = 700;
    params.SPLs     = [40 50 60 70 80];
    params.Ws       = 25;
    params.FSs      = 44100;
    
    % Standards definition
    stds(1).fm  = 4;
    stds(1).fc  = 1500;
    stds(1).df  = 700;
    stds(1).SPL = 60;
    stds(1).w   = 25;
    stds(1).fs  = 44100;
    
    stds(2).fm  = 4;
    stds(2).fc  = 1500;
    stds(2).df  = 700;
    stds(2).SPL = 40;
    stds(2).w   = 25;
    stds(2).fs  = 44100;

    spec.name = 'FM-SPL';
    spec.desc = [
        'Magnitude estimation experiment to determine the dependence ' ...
        'of sound pressure level on fluctuation strength for FM tones'
    ];
    spec.tone               = 'FM';
    spec.params             = params; 
    spec.stds               = stds;
    spec.std1               = 3;
    spec.n_stimuli          = length(params.SPLs);
    spec.norm               = 39.9335;
    
    spec.plot.xlabel        = 'Sound pressure level [dB]';
    spec.plot.x_handle      = @(x)x/10;
    spec.plot.dx            = 0.05;
    spec.plot.axis          = [-inf inf 20 120];
    
    spec.plot.experiment.x          = params.SPLs;
    spec.plot.model.xticklabel      = params.SPLs;
    spec.plot.fastl2007.x           = params.SPLs;
    spec.plot.fastl2007.xticklabel  = params.SPLs;
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
