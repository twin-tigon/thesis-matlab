function Generate_APEX_experiment_files
% function Generate_APEX_experiment_files
% 
% Generates APEX experiment files form specification handlers.
% 
% Author: Rodrigo García

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    SPEC_HANDLERS = { 
        @AM_fm;
        @AM_fc;
        @AM_md;
        @AM_SPL;
        @FM_fm;
        @FM_fc;
        @FM_df;
        @FM_SPL;
	};

    for iSpec = 1:length(SPEC_HANDLERS);
        spec_handler = SPEC_HANDLERS{iSpec,1};
        Generate_APEX_experiment_file(spec_handler());
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
