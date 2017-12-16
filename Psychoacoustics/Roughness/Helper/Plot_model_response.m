function Plot_model_response(tone,param,coef)
% function Plot_model_response(tone,param)
% 
% Plots roughness model response for a give tone type and parameter.
% 
% Inputs:
% tone: The tone type to use ('AM','FM').
% param; The parameter to use ('fm','fc','SPL','md','df')
% coef: The power coefficient to vary ('p_g','p_m','p_k').
% 
% Author: Rodrigo García

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Default arguments
    if nargin < 1
        tone = 'AM';
    end
    
    if nargin < 2;
        param = 'fm';
    end
    
    if nargin < 3
        coef = 'p_m';
    end

    % General parameters
    N    = 8192;
    fs   = 40960;
    
    % Power coefficients
    p_g  = 2;
    p_m  = 2;
    p_k  = 2;
    p_ri = [0.125 0.25 0.5 1 2];
    
    switch coef
        case 'p_g'
            p_g = p_ri;
        case 'p_m'
            p_m = p_ri;
        case 'p_k'
            p_k = p_ri;
    end
    
    % Stimuli parameters
    params = get_params(param,tone);
    
    % Stimuli generation
    x = generate_stimuli(param,params,tone,N,fs);
    
    % Roughness calculation
    r = calculate_roughness(x,p_g,p_m,p_k);
    
    % Roughness plot
    plot_roughness(r,p_ri,params,param);
    
    % Save_figure
    save_figure(tone,param,coef);
    
    function params = get_params(param,tone)
        % Base parameters
        params = struct;
        params.fm   = Tern(strcmp(param,'fm'),[10 30 50 70 100 150 200],70);
        params.fc   = Tern(strcmp(tone,'AM'),1e3,1.5e3);
        params.fc   = Tern(strcmp(param,'fc'),[125 250 500 1000 2000 4000 8000],params.fc);
        params.SPL  = Tern(strcmp(param,'SPL'),[40 50 60 70 80],70);
        params.md   = Tern(strcmp(param,'md'),[1 2 4 10 20 40],40);
        params.df   = Tern(strcmp(param,'df'),[32 64 128 300 700 1000 1250],700);
    end

    function x = generate_stimuli(param,params,tone,N,fs)
        x   = zeros(length(params.(param)),N);
        x_i = 1;
        
        for fm = params.fm
            for fc = params.fc
                for SPL = params.SPL
                    if strcmp(tone,'AM')
                        for md = params.md
                            x(x_i,:) = Create_AM(fc,fm,d2m(md),SPL,fs,N);
                            x_i      = x_i + 1;
                        end
                    else
                        for df = params.df
                            x(x_i,:) = Create_FM(fc,fm,df,SPL,fs,N);
                            x_i      = x_i + 1;
                        end
                    end
                end
            end
        end
    end

    function r = calculate_roughness(x,p_gs,p_ms,p_ks)
        x_s = size(x);
        r_s = max([length(p_gs) length(p_ms) length(p_ks)]);
        
        r = zeros(length(r_s),x_s(1));
        for l = 1:x_s(1)
            r_i = 1;
            for p_gt = p_gs
                for p_mt = p_ms
                    for p_kt = p_ks
                        r(r_i,l) = abs(Roughness(x(l,:)',p_gt,p_mt,p_kt));
                        r_i      = r_i + 1;
                    end
                end
            end
        end
    end

    function plot_roughness(r,p_ki,params,param)
        p   = params.(param);
        p_h = get_p_handle(param);
        p_t = p_h(p);

        figure;
        hold on;
        for k = 1:length(p_ki)
            plot(p_t,r(k,:),'--o');
        end
        set(gca,'XTick',p_t);
        set(gca,'XTickLabel',p);
        xlabel(get_xlabel(param));
        ylabel('Roughness [Asper]');
        legend(arrayfun(@(x)sprintf('%.3f',x),p_ki,'UniformOutput',false));
        grid on;
    end

    function save_figure(tone,param,coef)
        filename = [
            Get_path('LaTeX_Roughness_Model_img') ...
            sprintf('%s_%s-%s',coef,lower(tone),lower(param))
        ];
        Save_figure(filename);
    end

    function h = get_p_handle(param)
        switch param
            case 'fm'
                h = @log2;
            case 'fc'
                h = @log2;
            case 'SPL'
                h = @log10;
            case 'md'
                h = @log2;
            case 'df'
                h = @log2;
            otherwise
                h = @abs;
        end
    end
    
    function l = get_xlabel(param)
        switch param
            case 'fm'
                l = 'Modulation frequency [Hz]';
            case 'fc'
                l = 'Center frequency [Hz]';
            case 'SPL'
                l = 'Sound pressure level [dB]';
            case 'md'
                l = 'Modulation depth [dB]';
            case 'df'
                l = 'Frequency deviation [Hz]';
            otherwise
                l = '';
        end
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
