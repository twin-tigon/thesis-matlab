function Plot_experiment_results(spec,settings)
% function Plot_experiment_results
% 
% Plots APEX experiment results files for the given experiment
% specification.
% 
% Inputs:
% spec: The specification to process.
% settings: Struct with the following settings
%   data_path: The dir where the experimental data is located.
%   output_path: The dir where the generated figures will be saved.
%   individual_results: Whether individual results must be processed.
%   group_results: Whether group results must be processed.
%   stds_results: Whether standards figure must be generated.
%   comparison_results: Whether comparison figure must be generated.
%   smooth: Whether to use a smoothing spline in combined data.
%   show_figures: Whether to show figures.
%   save_figures: Whether to save figures.
% 
% Author: Rodrigo Garc?a

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Processes input arguments
    switch nargin
        case 0
            error(['You must specify at least an experiment' ...
                ' specification!']);
        case 1
            settings = struct;
    end
    
    fprintf('Processing experiment %s...\n',spec.name);
    
	% Sets default settings
    data_path = Get_field_default(settings,'data_path'...
        ,Get_path('FluctuationStrength_Experiment_Data'));
    output_path = Get_field_default(settings,'output_path'...
        ,Get_path('LaTeX_FluctuationStrength_Experiment_img'));
    individual_results = Get_field_default(settings,'individual_results'...
        ,false);
    group_results = Get_field_default(settings,'group_results',true);
    stds_results = Get_field_default(settings,'stds_results',false);
    comparison_results = Get_field_default(settings,...
        'comparison_results',true);
    smooth          = Get_field_default(settings,'smooth',true);
    show_figures    = Get_field_default(settings,'show_figures',true);
    save_figures    = Get_field_default(settings,'save_figures',false);
    
    if show_figures
        figures_visibility = 'on';
    else
        figures_visibility = 'off';
    end

    % Processes individual results
    if individual_results
        filenames = struct2cell(dir([data_path spec.name '_*.mat']));
        filenames = filenames(1,:);
        for f = 1:length(filenames)
            data    = load(filenames{f});
            answers = data.answers;
            process_results(answers,spec,stds_results...
                ,comparison_results,figures_visibility,smooth...
                ,save_figures...
                ,[output_path filenames{f}(1:end-4)]);
        end
    end
    
	% Processes group results
    if group_results
        data          = load([data_path spec.name '.mat']);
        group_answers = data.answers;
        
        process_results(group_answers,spec,stds_results...
                ,comparison_results,figures_visibility,smooth...
                ,save_figures...
                ,[output_path spec.name '_all']);
    end
    
	%% Helper functions
    
    function process_results(answers,spec,stds_results...
            ,comparison_results,figures_visibility,smooth,save_figures...
            ,output_filename)        
        if stds_results
            generate_figure(@generate_stds_figure,answers,spec...
                ,figures_visibility,smooth,save_figures...
                ,[output_filename '_standards']);
        end
        if comparison_results
            generate_figure(@generate_comparison_figure,answers...
                ,spec,figures_visibility,smooth,save_figures...
                ,[output_filename '_comparison']);
        end
    end

    function generate_figure(handle,answers,spec,figures_visibility...
            ,smooth,save_figures,output_filename)
        handle(answers,spec,figures_visibility,smooth);
        if save_figures
                save_figure(output_filename);
        end
    end

    function generate_stds_figure(answers,spec,figures_visibility...
            ,smooth)
        x  = get_x_values_from_spec(spec);
        dx = spec.plot.dx;
        
        figure('Visible',figures_visibility);
        
        add_plot(x,-dx,spec.n_stimuli,Cellfilter(answers,@(x)x.std==1)...
            ,'ob',@plot_errorbar);
        hold on;
        
        add_plot(x,dx,spec.n_stimuli,Cellfilter(answers,@(x)x.std==2)...
            ,'sr',@plot_errorbar);
        
        if smooth
            add_plot(x,0,spec.n_stimuli,answers,'-k',@plot_fit);
        else
            plot_mean(x,spec.n_stimuli,answers,'-k');
        end
        
        xlabel(spec.plot.xlabel);
        ylabel('Relative fluctuation strength [%]');
        legend('Standard 1','Standard 2','Combined');
        axis(spec.plot.axis);
        
        set(gca,'XTick',x);
        set(gca,'XTickLabel',spec.plot.experiment.x);
        set(gca,'FontSize',14);
        
        grid on;
        grid minor;
    end

    function generate_comparison_figure(answers,spec...
            ,figures_visibility,smooth)
        figure('Visible',figures_visibility);
        
        x = get_x_values_from_spec(spec);
        
        if smooth
            add_plot(x,0,spec.n_stimuli,answers,'--',@plot_fit);
        else
            plot_mean(x,spec.n_stimuli,answers,'--b');
        end
        
        hold on;
        
        Plot_Fastl2007Psychoacoustics({spec},smooth,false,'-.r');
        
        xlabel(spec.plot.xlabel);
        ylabel('Relative fluctuation strength [%]');
        legend('Experiment','Fastl2007');
        set(gca,'XTick',x);
        set(gca,'XTickLabel',spec.plot.experiment.x);
        set(gca,'FontSize',14);

        axis([-inf inf -inf inf]);
        
        grid on;
        grid minor;
    end

    function x = get_x_values_from_spec(spec)
        x = spec.plot.x_handle(spec.plot.experiment.x);
        
        % Ugly hack to accomodate for Inf value in *-fm experiments
        if Vectorreduce(isinf(x),@or)
            x(1) = x(2) - 1;
        end
    end

    function add_plot(x,dx,n,answers,linespec,plot_handle)
        vals = Get_values_per_level(answers,n);
        plot_handle(x+dx,vals,linespec);
    end

    function plot_mean(x,n,answers,linespec)
        vals_1 = Get_values_per_level(Cellfilter(answers,@(x)x.std==1),n);
        [m1,~] = Extract_stats(vals_1);
        vals_2 = Get_values_per_level(Cellfilter(answers,@(x)x.std==2),n);
        [m2,~] = Extract_stats(vals_2);
        
        m = (m1+m2)*0.5;
        plot(x,m,linespec);
    end

    function plot_fit(x,vals,linespec)
        [m,~] = Extract_stats(vals);
        [xData, yData] = prepareCurveData(x,m);
        ft = fittype('smoothingspline');
        [fitresult, ~] = fit(xData, yData, ft);
        plot(fitresult,linespec);
    end

    function plot_errorbar(x,vals,linespec)
        [m,l,u] = Extract_stats(vals);
        errorbar(x,m,l,u,linespec);
    end

    function save_figure(filename)
        delete([filename '.eps']);
        print(filename,'-depsc');
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
