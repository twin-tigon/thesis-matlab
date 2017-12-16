function Plot_Fastl2007Psychoacoustics(specs,fig_smooth,standalone...
    ,linespec)
% function Plot_Fastl2007Psychoacoustics
%
% Plots the data from Fastl2007Psychoacoustics.
%
% Inputs:
% specs: The specifications to plot.
% fig_smooth: Whether to use a smoothing spline in the plot.
% standalone: If the script should generate its own figure.
% linespec: The linespec to use for the combined plot.
% 
% Author: Rodrigo Garc?a

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if nargin < 4
        linespec = '-k';
    end

    if nargin < 3
        standalone = true;
    end
    
    if nargin < 2
        fig_smooth = false;
    end
        
    if nargin < 1
        specs = Get_specs;
    end
    
    settings = struct;
    
    settings.s_ls       = {'ob', 'sr'};
    settings.c_ls       = linespec;
    settings.dx         = [0.1 -0.1];
    settings.smooth     = fig_smooth;
    settings.standalone = standalone;

    cellfun(@(x)plot_spec(x,settings),specs);
    
    %% Helper functions
    
    function plot_spec(spec,settings)
        filename    = [Get_path('FluctuationStrength_Literature') ...
            'Data/' spec.name '.csv'];
        data        = Get_Fastl2007Psychoacoustics_data(filename);
        plot_data(data,spec,settings);        
    end
   
    function plot_data(data,spec,settings)
        if settings.standalone
            figure;
        end
        
        x = spec.plot.fastl2007.x;
        
        i = ~isnan(x);
        if Vectorreduce(~i,@or)
            x = [x(i)'; (interp1(data.x(i),x(i),data.x(~i)))];
            c = [data.c(i); data.c(~i)];
            
            [x,s_i] = sort(x);
            c       = c(s_i);
        else
            c = data.c;
        end
        
        % Assures that maximum value is 100%
        c_m = max(c);
        c   = 100*c/c_m;
        c
        
        if isfield(data,'m')
            data.m = 100*data.m/c_m;
            data.l = 100*data.l/c_m;
            data.u = 100*data.u/c_m;
        end
        
        x  = spec.plot.x_handle(x);
        
        if isfield(data,'m') && settings.standalone
            hold on;
            for std = 1:2
                if strcmp(spec.name,'FM-fc')
                    i = data.s ~= std;
                else
                    i = data.s == std;
                end
                errorbar(x-settings.dx(std),data.m(i),...
                    data.m(i)-data.l(i),data.u(i)-data.m(i),...
                    settings.s_ls{std});
            end
        end

        if settings.smooth
            [xData, yData] = prepareCurveData(x,c);
            ft = fittype('smoothingspline');
            [fitresult, ~] = fit(xData, yData, ft);
            plot(fitresult,settings.c_ls);
        else
            line(x,c,'LineStyle','-','Color','k');
        end
        
        if settings.standalone
            xlabel(spec.plot.xlabel);
            ylabel('Relative fluctuation strength [%]');
            set(gca,'box','off');
            set(gca,'XTick',x);
            set(gca,'XTickLabel',spec.plot.fastl2007.xticklabel);
            set(gca,'FontSize',14);
            
            if isfield(data,'m')
                legend('Standard 1','Standard 2','Combined');
            end
            
            axis(spec.plot.axis);
             
            grid on;
            grid minor;
        end
        
        filename = [Get_path('LaTeX_Thesis_Chapter_img') 'fastl2007_' ...
            spec.name];
        Save_figure(filename);
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
