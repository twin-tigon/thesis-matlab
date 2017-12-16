function Plot_model_responses
% function Plot_model_responses
% 
% Plots all roughness model responses.
% 
% Author: Rodrigo García

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    tones       = {'AM','FM'};
    params_AM   = {'fm','fc','SPL','md'};
    params_FM   = {'fm','fc','SPL','df'};
    coefs       = {'p_g','p_m','p_k'};
    
    for tone = tones
        params = Tern(strcmp(tone,'AM'),params_AM,params_FM);
        for param = params
            for coef = coefs
                Plot_model_response(char(tone),char(param),char(coef));
            end
            
        end
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
