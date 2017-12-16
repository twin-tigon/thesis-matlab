function Plot_experiment_model(x,y_e,y_m,spec)
% function Plot_experiment_model(x,y_e,y_m,spec)
% 
% Plots the experimental and the model data.
% 
% Inputs:
% x: The x values vector.
% y_e: The experimental data.
% y_m: The model data.
% spec; The specification that corresponds to the data.
% 
% Author: Rodrigo Garc?a

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    hold on;

    plot(x,y_e,'--ob');
    plot(x,y_m,'-k');

    xlabel(spec.plot.xlabel);
    ylabel('Fluctuation strength [Vacil]');
    legend('Experiment','Model');
    
    textbox_pos = get(gca,'Position') + [0.01 -0.01 0 0];
    textbox = annotation('textbox', textbox_pos,'String'...
        ,['\Sigma {r_i}^2 = ' sprintf('%.2f',Get_sum_r2(y_e,y_m))]...
        ,'FontSize',14);
    textbox.FitBoxToText = 'on';

    set(gca,'XTick',x);
    set(gca,'XTickLabel',spec.plot.model.xticklabel);
    set(gca,'FontSize',14);
    
    axis([-inf inf 0 inf]);

    grid on;
    grid minor;
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
end
