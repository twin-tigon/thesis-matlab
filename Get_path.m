function path = Get_path(name)
% function path = Get_path(name)
% 
% Function to retrieve support paths that change according to the runtime
% environment.
% 
% Author: Rodrigo Garc�a

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    paths = Get_Thesis_paths;

    APEX_base = ['/Users/rodrigogarcialeon/Repositories/thesis-apex'];
    LaTeX_base = '/Users/rodrigogarcialeon/Repositories/thesis-latex';
        
    LaTeX_FluctuationStrength = [LaTeX_base 'topic/fluctuation_strength/'];
    LaTeX_Roughness           = [LaTeX_base 'topic/roughness/'];

    paths.APEX_stimulus     = [ APEX_base 'stimulus/' ];
    paths.APEX_experiment   = [ APEX_base 'experiment/' ];
    paths.APEX_result       = [ APEX_base 'result/' ];
    
    paths.LaTeX_FluctuationStrength_Experiment_img = [ ...
        LaTeX_FluctuationStrength 'experiment/img/'
    ];

    paths.LaTeX_FluctuationStrength_TestBattery_img = [ ...
        LaTeX_FluctuationStrength 'test_battery/img/'...
    ];

    paths.LaTeX_FluctuationStrength_Pilot_img = [ ...
        LaTeX_FluctuationStrength 'pilot/img/'
    ];

    paths.LaTeX_FluctuationStrength_Model_img = [ ...
        LaTeX_FluctuationStrength 'model/img/'
    ];

    paths.LaTeX_FluctuationStrength_Model_Data_Fitting_img = [ ...
        LaTeX_FluctuationStrength 'model/data_fitting/img/'
    ];

    paths.LaTeX_Roughness_Model_img = [ ...
        LaTeX_Roughness 'model/img/'
    ];
    
    if ~isfield(paths,name)
        error('The requested path has not been defined!');
    end
    
    path = paths.(name);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
