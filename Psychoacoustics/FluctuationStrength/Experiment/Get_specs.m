function specs = Get_specs
% function Get_specs
% 
% Returns cell array with all the experiment specifications.
% 
% Output:
% specs: The cell array containing the specifications. 
% 
% Author: Rodrigo García

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    handles = {@AM_fm @AM_fc @AM_md @AM_SPL @FM_fm @FM_fc @FM_df @FM_SPL};
    specs   = cellfun(@(x)x(),handles,'UniformOutput',false);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
