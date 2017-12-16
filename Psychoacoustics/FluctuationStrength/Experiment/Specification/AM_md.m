function spec = AM_md
% function spec = AM_md
% 
% Specification for AM-md experiment.
% 
% Author: Rodrigo Garc?a

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Stimuli parameters
    params.FMs      = 4;
    params.FCs      = 1000;
    params.MDs      = [1 2 4 10 20 40];
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
    stds(2).fc  = 1000;
    stds(2).md  = 4;
    stds(2).SPL = 70;
    stds(2).w   = 25;
    stds(2).fs  = 44100;

    spec.name = 'AM-md';
    spec.desc = [
        'Magnitude estimation experiment to determine the dependence ' ...
        'of modulation depth on fluctuation strength for AM tones'
    ];
    spec.tone               = 'AM';
    spec.params             = params; 
    spec.stds               = stds;
    spec.std1               = 6;
    spec.n_stimuli          = length(params.MDs);
    spec.norm               = 84.1651;
    
    spec.plot.xlabel        = 'Modulation depth [dB]';
    spec.plot.x_handle      = @log2;
    spec.plot.dx            = 0.1;
    spec.plot.axis          = [-inf inf 0 120];
    
    spec.plot.experiment.x          = params.MDs;
    spec.plot.model.xticklabel      = params.MDs;
    spec.plot.fastl2007.x           = [1 2 4 NaN 8 NaN NaN 20 40];
    spec.plot.fastl2007.xticklabel  = {'1' '2' '4' '' '8' '' '' '20' '40'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
