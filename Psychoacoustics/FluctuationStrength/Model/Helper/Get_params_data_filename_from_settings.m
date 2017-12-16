function filename = Get_params_data_filename_from_settings(settings)
% function filename = Get_params_data_filename_from_settings(settings)
% 
% Returns params data filename from given settings.
% 
% Inputs:
% settings: The given settings.
% 
% Outputs:
% filename: The params data filename.
% 
% Author: Rodrigo Garc?a

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    filename = sprintf('params_fs-%i_Chno-%i.mat'...
        ,settings.fs,settings.Chno);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
