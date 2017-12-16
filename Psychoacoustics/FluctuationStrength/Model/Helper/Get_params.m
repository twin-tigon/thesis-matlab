function params = Get_params(fs,Chno)
% function params = Get_params(fs,Chno)
% 
% Returns a struct with all the required parameters for the fluctuation
% strength model.
% 
% Inputs:
% fs: the sampling frequency.
% Chno: the number of channels.
% 
% Outputs:
% params: Parameters struct
%
% Author: Rodrigo Garc?a

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

    if nargin ~= 3
        error('You must specify all the parameters!');
    end
    
    settings       = struct;
    settings.fs    = fs;
    settings.Chno  = Chno;

    PARAMS_FILE = Get_params_data_filename_from_settings(settings);

    if ~exist(PARAMS_FILE,'file')
        Create_params(fs,Chno,PARAMS_FILE);
    end
    
    params = load(PARAMS_FILE);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
